---
layout: post
title:  "Alert on symptoms, not causes"
date:   2024-03-06 14:00:00 +0200
categories:
---
When you are bringing a new system to production you know that you ought
to define SLIs, set up instrumentation, alerting, etc. Nowadays there is
an abundance of tooling and infrastructure to extract data from your
service and the entire stack it runs on. But this leaves you with a
problem. What can we do with that data? Should you put all of it on a
dashboard, in many? What should trigger an alert and wake you up in the
middle of the night? The possibilities are endless, as Lou Reed would
[sing](https://open.spotify.com/track/6tM8cMX9S4AyRd5sDDrzhN?si=8b60aa7658d74711).

Teams usually start sieving through their data from generalised
monitoring dashboards available in every major observability platform.
They find the usual charts with resources like CPU, memory, IO, and
threads. JVM users get heap and non-heap usage, pauses, and collection
times. APIs expose latency, throughput, and HTTP response codes, all
exhaustively broken down by endpoint. There is an understandable urge to
watch for any source of trouble. All that data seems important, so the
next step is setting alert triggers on all of them with whatever
thresholds seem reasonable at the time.

What follows is a Niagara of alerts that aren’t quite one. It could be
that a sudden CPU spike to 91% crosses the threshold, only to be
dismissed as being due to the JVM just cleaning some garbage. The team
will try to fine tune the alert (”maybe trigger only if it’s 90% for
more than 2 minutes”), only to be hit by another false positive on
whatever other of the dozens of alerts. After much stitching, false
positives will go down. Then, an actual incident will slip undetected
through the patchwork of alert thresholds.

Sometimes teams will treat this as part of the inevitable toil that goes
with operating production software, like carrying extra weight in your
backpack during the on-call shift. 

Being perhaps too lazy, when I build systems I aspire to make
operational toil so small that on-call feels like a free bonus. Of
course it’s hard to get there because operating software creates
problems that sometimes require human effort. But a deluge of noisy
instrumentation isn’t one of those problems. Don’t resign yourself to
it.

## Symptoms before causes

To turn instrumentation data into high signal my default approach is to
start by focusing on symptoms before causes. 

This often feels counter intuitive to engineers. Our instinct says that
high CPU usage is a harbinger for trouble, so it would seem wise to
alert when it exceeds that threshold. While there is nothing
intrinsically wrong with this, it quickly becomes impractical. There are
innumerable other causes for trouble. Just like high CPU usage, you
could take each of the dozens of “seems quite important” default metrics
produced by your instrumentation framework, and think of thresholds
above which things might start going awry.

It’s a case of how an aggregation of good individual decisions sometimes
produces a negative outcome. High CPU usage might signal a failure with,
for example, 75% success rate. But that also means a 25% chance of being
false positive. Every time this alert triggers preemptively you place
a burden on the operator to confirm whether it is actually relevant.
As you add more metrics for the many other possible causes of trouble,
the odds of suffering false positives accumulates to unpleasant levels
quite fast. Discomfort is not even the biggest problem with noisy
alerts. Lots of alerts with low signal ratio slowly induce your team
to ignore them, miss actual incidents and worsen their impact.

## Going beyond “just in case” alerting

The cause-first approach is “just in case” alerting. A symptom-first
approach is less about probabilities than certainties. It’s not about
answering “what might cause a problem” but “what external behaviour
manifests that my service is not healthy”.

An example of a symptom could be an API’s latency going through the
roof. We don’t know what is causing it, it could be CPU or a million
other things. But we are positive that the service is not doing its
job as expected, so we know that the PagerDuty horn that’s about to
bring the sleeping engineer into cardiac arrest is worth blowing.
It is at this point that the knowledge and intuitions about probable
causes and the fancy instrumentation you collected from the system
become useful and usable. You start with the symptom: latency. Then
you move on to check probable causes, like CPU usage or GC activity.
If those aren’t the actual causes, you have a treasure trove of
telemetry at your disposal to search for anomalies that might explain
the problem that you do know you have.

## Causes for failure are permanent residents

Another problem with focusing on causes is that after a system reaches
a certain level of complexity (by 2024, even the most trivial software
sits on top of complex systems), causes for failure are not only
diverse. They are also everywhere. This is Richard Cook on “[How
complex systems fail](https://how.complexsystems.fail/#3)”:

    3. Complex systems contain changing mixtures of failures latent within
    them. The complexity of these systems makes it impossible for them to
    run without multiple flaws being present. […]

    4. Complex systems run in degraded mode. Complex systems run as broken
    systems. The system continues to function because it contains so many
    redundancies and because people can make it function, despite the
    presence of many flaws.

His point is that in a complex system, there are always potential
causes of trouble lying somewhere in between the cogs. You can’t blow
the horn continuously just in case the potential cause did create an
actual problem this time. When something isn’t exceptional, alerting
on its presence loses most of its value and, as we noted above, tends
to become counter-productive by desensitising operators.

Instead, your system will be better off treating the presence of
potential causes of failure as normal operation. It should work
despite being exposed to them, and trigger an alert only when it is
unable to perform its function and attention from operators is really
necessary.

## Good SLOs are almost always symptoms

Answers to “what external behaviour manifests that my service is not
healthy” tend to overlap with answers to “how would a user tell that the
service doesn’t work” or “how would the business tell that we’re making
money“. Symptoms get you talking about page loading times, conversions,
successful page loads, and so on. Terms closer to user experience and
business objectives. They may seem too far away from the guts of the
system, but will give you clarity and purpose. It’s almost impossible to
figure out how much time per month you can tolerate with >90% CPU
utilisation. It’s much easier to figure out what is the acceptable
percentage of failed requests. 

Being on the same wavelength as the business gives engineers more
control over alert fatigue and toil. The handful of symptoms that become
SLOs allow you to reduce drastically the amount of alerts we need to
configure and attend to.

SLOs also imply an error budget, and knowing how much failure is
acceptable in a period of time gives your team the option to keep the
PagerDuty horn silent until your error budget is at risk. This doesn’t
mean you should become complacent and tolerate errors, but that you can
(and should!) administer the demand for your team’s limited energy.
Similarly, associating each cause of failure with its effect on SLOs
helps prioritise investing in the most impactful (which won’t
necessarily be the most frequent!). 

## Summary

When you define health alerts for your systems it’s more useful to start
with symptoms of trouble, rather than potential causes.

Causes usually look at resources (CPU, memory, IO, etc.) or internal
processes (GC, thread scheduling, etc.), but the presence of a cause
does not guarantee an issue. This adds the burden of confirmation on the
operator, which gets multiplied because there are many potential causes
of failure. In a complex system, they are also always present.  All
these factors lead to excess alert noise, fatigue operators, and make
them less effective at keeping the system healthy. 

Symptoms look at high-level function (requests served in time, data
flowing, payments being processed). Symptoms are few, and provide
reliable indicators that the system is unable to perform its job. An
alert gives near certainty that attention for the operator is necessary.
Focus on symptoms aligns engineering priorities with those of the
business, and helps define SLOs and error budgets that guide engineering
towards more effective and efficient use of their effort, and gives
control over operational toil.

## (Some) further reading

* “[Love (and Alerting) in the Time of Cholera (and
  Observability)](https://charity.wtf/2019/09/20/love-and-alerting-in-the-time-of-cholera-and-observability/)”.
* “[Choosing good SLIs](https://bravenewgeek.com/choosing-good-slis/)”.
* [Google’s SRE bookshelf](https://sre.google/books/).

