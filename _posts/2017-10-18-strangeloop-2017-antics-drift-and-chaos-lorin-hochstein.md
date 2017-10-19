---
layout: post
title:  "StrangeLoop 2017: Antics, Drift and Chaos, Lorin Hochstein (Netflix)"
date:   2017-10-18 11:31:22 +0200
categories: systems strangeloop netflix chaos failure
---

* [Talk](https://www.youtube.com/watch?v=SM2uXpmyJmA)
* [Slides](http://lorinhochstein.org/strange-loop.pdf)

## How do systems fail

* Any large system is going to be operating most of the time in failure
  mode. [John
  Gall](https://www.amazon.com/Systems-Bible-Beginners-Guide-Large/dp/0961825170
  "The systems bible")
* You must be handing failure all the time, because failure happens all
  the time.
* 92% of catastrophic failures are the result of incorrect handling of
  non-fatal errors explicitly signalled in software. ([Ding
  Tuan](https://www.youtube.com/watch?v=fLubzgwcSW4 "Simple testing can prevent most critical failures in distributed data-intensive systems, OSDI 2014"))

Common failure scenario in a microservice arch:

    Service becomes latent
    -> clients timeout
    -> clients retry
    -> load increases
    -> latency increases
    -> more retries
    -> retry storm

Most major incidents will be due to:
1. Unexpected behaviour of a support system.
2. Attempt to mitigate a non-critical incident.

Mechanisms that improve availability (error handling, support systems,
mitigation) also create outages.  This makes building reliable systems
much harder.

## Why do systems fail

Inherent software complexity, resource constraints, local decisions,
history all contribute to system failure.

### Unruly technology

* We build our systems out of stuff that we really don't understand how
  it will behave.
* Our technologies have got ahead of our theories ([Sidney Dekker](https://www.amazon.com/Drift-into-Failure-Components-Understanding/dp/1409422216))
* Fault tolerance isn't composable. ([Peter Alvaro](https://people.ucsc.edu/~palvaro))
* We can't model our systems. [Pedro
  Fonseca](https://homes.cs.washington.edu/~pfonseca/papers/eurosys2017-dsbugs.pdf "Pedro Fonseca et al.: An empirical study on the correctness of formally verified distributed systems. EuroSys 2017."): 
  even formally verified systems exhibit bugs: they run on real OS and
  they need some form of interface to those OS.  These connecting layers
  are the most common source of errors.

### Scarcity and competition

* Resource constraints lead to tradeoffs such as efficiency vs.
thoroughness. Temporary patches will very likely be permanent.

### Decrementalism
* Drift happens in small steps.
* Diane Vaughan: [Normalization of
  deviance](https://en.wikibooks.org/wiki/Professionalism/Diane_Vaughan_and_the_normalization_of_deviance)
  (common behaviour patterns: "yeah we don't test that", "it's been
  broken for a while.." etc.)

### Sensitive dependence on initial conditions.
* A complex system that works is inavariably found to have evolved from
  a simple system that worked. ([John Gall](https://www.amazon.com/Systems-Bible-Beginners-Guide-Large/dp/0961825170 "The systems bible"))
* We make local decisions that have non-local impact.
* Structural secrecy ([Diane
  Vaughan](https://www.amazon.com/Challenger-Launch-Decision-Technology-Deviance/dp/022634682X
  "The Challenger launch decision")): the information that you need to
  know to make a decision is somewhere in the org that you don't have
  access to.

## What to do

* Make doing the wrong thing harder.

### Chaos Monkey

* Because we can't model systems, we explore real systems in production
  to find vulnerabilities *before* they can cause an outage.
* We do drug experiments on humans for the same reason.
    * This doesn't preclude doing experiments in lab & animals before.
* [Principles of chaos](https://principlesofchaos.org)
    * Build a hypothesis around steady state behaviour.
    * Vary real-world events: inject something new.
    * Add latency to RPC calls.
    * Run experiments in production.
    * Automate experiments to run continuously.
        * Integrate with deployment pipelines.
    * Minimize blast radious.
        * Route small % of traffic.
        * Stop experiments early.

## References

Books, papers, etc. mentioned in the talk.

* [Diane Vaughan: The Challenger Launch Decision](https://www.amazon.com/Challenger-Launch-Decision-Technology-Deviance/dp/022634682X)
* [Ding Tuan: Simple testing can prevent most critical failures in distributed data-intensive systems, OSDI 2014](https://www.youtube.com/watch?v=fLubzgwcSW4)
* [John Gall: The systems bible](https://www.amazon.com/Systems-Bible-Beginners-Guide-Large/dp/0961825170)
* [Pedro Fonseca et al.: An empirical study on the correctness of formally verified distributed systems. EuroSys 2017.](https://homes.cs.washington.edu/~pfonseca/papers/eurosys2017-dsbugs.pdf)
* [Principles of chaos](https://principlesofchaos.org)
* [Rosenthal, Hochstein, Blohowiak, Jones, Basiri: Chaos engineering (free ebook)](http://www.oreilly.com/webops-perf/free/chaos-engineering.csp)
* [Ryan Huang et al.: Gray failure: the Achilles' hell of cloud-scale systems, HotOS 2017](https://www.cs.jhu.edu/~huang/paper/grayfailure-hotos17.pdf)
* [Sidney Dekker: Drift into Failure](https://www.amazon.com/Drift-into-Failure-Components-Understanding/dp/1409422216/)
* [Zhenyu Guo et al.: Failure Recovery: when the cure is worse than the disease, HotOS 2013](https://www.usenix.org/conference/hotos13/session/guo)
