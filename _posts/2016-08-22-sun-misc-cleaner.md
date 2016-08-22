---
layout: post
title:  "Contention on sun.misc.Cleaner"
date:   2016-08-22 19:00:00 +0200
categories: java jvm unsafe
---

I found recently a (dying) JVM with about 10 threads BLOCKED on the
_sun.misc.Cleaner_ class instance.  This was not the root cause of the
failure, but I could learn something by investigating those blocks.

A common & simple (not ideal) way to trigger the release of the memory
backing a _DirectByteBuffer_ is:

    sun.misc.Cleaner cleaner = ((DirectBuffer) buffer).cleaner();
    cleaner.clean();

All _DirectByteBuffers_ contain a _Cleaner_, which is a type of
[PhantomReference][1].  _PhantomReference_ differs from its relatives
_SoftReference_ and _WeakReference_ in that it allows us to execute
actions *after* the JVM has performed all collection tasks related to
referent, including running its finalizer.  As "**Effective Java**"
advises in Item 6, finalizers should be avoided as "_unpredictable,
often dangerous, and generally unnecessary._"  Indeed, they are
sensitive to GC, JVM implementations, and risk exposing references to
about-to-be collected objects that will prevent their collection.
_PhantomReference_ is a convenient alternative.

The _Cleaner_ works as described in its [Javadoc][2]:

    The cleaner tracks a referent object and encapsulates a thunk of
    arbitrary cleanup code. Some time after the GC detects that a
    cleaner's referent has become phantom-reachable, the
    reference-handler thread will run the cleaner.

As we know, the _ReferenceHandler_ is one of the JVM threads related to
Garbage Collection tasks, it will appear in any thread dump.  The
cleaner execution happens precisely by invoking
[Reference::tryHandlePending][3]

```
static boolean tryHandlePending(boolean waitForNotify) {
    Reference<Object> r;
    Cleaner c;
    try {
        synchronized (lock) {
            if (pending != null) {
                r = pending;
                // 'instanceof' might throw OutOfMemoryError sometimes
                // so do this before un-linking 'r' from the 'pending' chain...
                c = r instanceof Cleaner ? (Cleaner) r : null;

    [...]

    // Fast path for cleaners
    if (c != null) {
        c.clean();
        return true;
    }
```

That is, once a referent is collected, the _ReferenceHandler_ will take
the corresponding _Reference_, and if it's a _Cleaner_ (as our case)
invoke the clean method on it.

The last [quoted paragraph][2] continues:

    Cleaners may also be invoked directly; they are thread safe and ensure
    that they run their thunks at most once.

Why would we want to invoke cleaners directly?

Because it's hard to predict when the _DirectByteBuffer_ will be
collected and return its underlying native memory to the OS.  For
example, imagine an application that generates mostly short-lived
objects and promotes very few objects to the Old Generation.  It will
take a long time (hours?  days?) to trigger a Major GC (which cleans the
Old Generation).  If one of these tenured objects is a
_DirectByteBuffer_, it will keep hold of the underlying native memory
even long after it becomes unreachable.  To make things worse, cleaning
_PhantomReferences_ (as well as Soft or Weak ones) requires [two GC
cycles][4].

So it makes sense that we can call the _Cleaner_ explicitly and thus
expedite releasing that memory.  That's is typically done as shown at
the beginning, or if we want to avoid the _sun.misc.Cleaner_ import:

    Method cleanerMethod = buffer.getClass().getMethod("cleaner");
    cleanerMethod.setAccessible(true);
    Object cleaner = cleanerMethod.invoke(buffer);
    Method cleanMethod = cleaner.getClass().getMethod("clean");
    cleanMethod.setAccessible(true);
    cleanMethod.invoke(cleaner);

Which should be Oracle/OpenJDK friendly, although not totally platform
independent.

Taking a look at the [Cleaner source][5], it turns out that both _add_
and _remove_ methods, which are called when instantiating a new DBB, and
after invoking the _Cleaner_, are static and synchronized, so they'll
both coordinate using the monitor from the _Cleaner_ class instance
itself.

    private static synchronized Cleaner add(Cleaner c1)
    private static synchronized boolean remove(Cleaner c1)

Which means that we have contention among all application threads trying
to create or dispose _DirectByteBuffer_ instances, plus the
_ReferenceHandler_ thread.  Not good.

I already knew that DBBs are better reused than created frequently,
because native memory allocations are much more expensive than in heap.
So here is another reason: high rate of cleanup and creation **also**
adds contention on the _sun.misc.Cleaner_ class instance.

One would assume that the rate of allocations of DBB should never be so
high as to turn this into a problem.  Except when it does.  Our JVM ran
a legacy service where a misbehaving connection pool caused lots of new
connections being destroyed and re-created, along with their internal
_DirectByteBuffer_.  The situation degraded enough to make DBB
allocations and releases impact the _ReferenceHandler_ (thus, GC) and
create manifest contention on _Cleaner_ which contributed to snowballing
to a complete loss of service.

[1]: https://docs.oracle.com/javase/8/docs/api/index.html?java/lang/ref/PhantomReference.html
[2]: http://www.kdgregory.com/index.php?page=java.refobj
[3]: http://hg.openjdk.java.net/jdk8u/jdk8u/jdk/file/5beaee665e14/src/share/classes/java/lang/ref/Reference.java#l174
[4]: https://community.oracle.com/blogs/enicholas/2006/05/04/understanding-weak-references
[5]: http://hg.openjdk.java.net/jdk8u/jdk8u/jdk/file/5beaee665e14/src/share/classes/sun/misc/Cleaner.java#l78
