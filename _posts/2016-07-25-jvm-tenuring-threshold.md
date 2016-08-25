---
layout: post
title:  "How does the JVM change tenuring thresholds, and when?"
date:   2016-07-25 22:29:02 +0200
categories: jvm java garbage-collection
---

On a recent Tuesday evening I ran into this [3 year old JVM
question](https://stackoverflow.com/questions/22350002/how-does-the-dynamic-tenuring-threshold-adjustment-work-in-hotspot-jvm/)
in Stack Overflow.  GC features and its many knobs are profusely
documented (search adaptive policy, tenuring threshold..) but asking too
many questions inevitably leads to hitting the confines of the
proverbial black box.  Yeah, tenuring thresholds are dynamic.. but
how, why and when do they change?

Luckily, the [JVM
codebase](http://hg.openjdk.java.net/jdk8u/jdk8u/hotspot/file/c171546c49b5)
is there to take a peek.  GC stuff can be found under
`src/share/vm/gc_implementation`.

According to [ageTable.cpp
L81](http://hg.openjdk.java.net/jdk8/jdk8/hotspot/file/87ee5ee27509/src/share/vm/gc_implementation/shared/ageTable.cpp#l81)
and next (method `compute_tenuring_threshold`) the JVM will iterate
through each age and add up the size of objects with that age. As soon
as it exceeds the `desired_survivor_size` it'll stop and assume the last
age it got to as the candidate new threshold.  The new chosen threshold
is `min(candidateAge, MaxTenuringThreshold)`.

`compute_tenuring_threshold` is called in G1 from
[g1CollectorPolicy.cpp L1459](http://hg.openjdk.java.net/jdk8/jdk8/hotspot/file/8f07aa079343/src/share/vm/gc_implementation/g1/g1CollectorPolicy.cpp#l1459)
which choses a `_max_survivor_regions` based on
`ceil(_young_list_target_length / SurvivorRatio)` before calling the
compute method mentioned above.

That `young_list_target_length` is updated in
[g1CollectorPolicy.cpp](http://hg.openjdk.java.net/jdk8/jdk8/hotspot/file/8f07aa079343/src/share/vm/gc_implementation/g1/g1CollectorPolicy.cpp#l587)
as explained in the source:

    587   // Update the young list target length either by setting it to the
    588   // desired fixed value or by calculating it using G1's pause
    589   // prediction model. If no rs_lengths parameter is passed, predict
    590   // the RS lengths using the prediction model, otherwise use the
    591   // given rs_lengths as the prediction.
    592   void update_young_list_target_length(size_t rs_lengths = (size_t) -1);

I'll leave the model for another day, but this should already answer the
first question: tenuring threshold changes are triggered after a lower
number of ages is enough to keep the `desired_survivor_size` (which
AFAIK is explained
[here](http://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html)).
The new threshold is chosen based on given / predicted RS ([Remember
Set](https://blogs.oracle.com/g1gc/entry/g1_gc_glossary_of_terms))
lengths.

This process happens right at the beginning of a new collection pause,
as described in
[g1CollectorPolicy.cpp L839](http://hg.openjdk.java.net/jdk8/jdk8/hotspot/file/8f07aa079343/src/share/vm/gc_implementation/g1/g1CollectorPolicy.cpp#l839):

    839   // We only need to do this here as the policy will only be applied
    840   // to the GC we're about to start. so, no point is calculating this
    841   // every time we calculate / recalculate the target young length.
    842   update_survivors_policy();

I understand that the threshold will thus be updated *before* the GC
runs.  If that's the case, as live objects in survivor regions are
visited, all objects that have `object.age > newAge` will be tenured
(including those that had `age < threshold` at a previous collection,
but now exceed it).

PRs with corrections are very welcome.
