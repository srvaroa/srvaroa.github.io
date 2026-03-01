---
layout: post
title:  "Inferencing delivery bottlenecks away"
date:   2026-03-01 13:00:00 +0200
categories:
---

One of the hardest parts of integrating AI in our workflows is realizing that
you can, and probably should, throw away assumptions and re-evaluate trade-offs
from scratch. 

Unit tests are insufficient on their own to guarantee the correctness of a
larger system so we rely on integration / e2e to fill the gap. But the latter
are also slower and resource-hungry so as the number of tests grows, iteration
speed suffers and delivery pipelines become unscalable. 

What everyone always wanted was to avoid running the entire suite of
integration / e2e tests for every single change, and filter only relevant ones.
But the problem of calculating the code paths  affected by a given change is
hardest precisely at the integration / e2e layer, where the dependency graph
isn’t visible at compilation time and crosses network and system boundaries. 

So the dilemma was never really solved. Other than the consultants coming up
with a revised [geometry of
tests](https://varoa.net/2024/02/06/how-about-we-forget-the-concept-of-test-types.html)
every five-odd years, each organization settled on a custom mix of testing
layers that provided enough confidence, not too much friction, reasonable
costs, and got on with their business. Even so, scalability problems in
delivery pipelines were routine even in industry leaders[^1].

With the growing deluge of code hitting every delivery pipeline these days,
whatever equilibrium existed is no more. In the same way as [code reviews can’t
keep up](https://varoa.net/2026/02/22/code-reviews-cant-keep-up.html), running
the entire suite of tests for 10x, 100x more PRs is just not sustainable. And
the problem hits explosively in integration and e2e tests. Even if they can be
parallelized (e.g. full environment in a GitHub runner or ephemeral
environment), cost and duration are problematic. Others depend on staging or
persistent production replicas.

Finding the relevant subset of integration / e2e tests might have just become a
lot simpler. An LLM can actually understand systems and features at a much
higher level. So a small decision step in our delivery pipeline can evaluate
individual changes to any part of a larger system, using architecture
documents, API specs and similar context, and produce a reasonably relevant
subset of tests.

The type of prompt I’m using looks like this:

> Look at this diff. Use $architecture_knowledge_base and tell me the subset of e2e tests that would be relevant to execute to validate this feature with reasonable confidence.
> 

The key is of course the `$architecture_knowledge_base`. Integration/E2E tests
cover the surface of a System Under Test so the LLM needs to have a reasonable
picture of its internal structure. In the simplest case, the entire system and
test suite lives in a monorepo, so the LLM has everything it needs on the
checkout. In other cases, the monorepo is too large and the exploration costs
way too many tokens. Or the change lives in a different repository than other
components of the system, and even the integration / e2e test suite. But the
idea doesn’t change much. The `$architecture_knowledge_base` might just be a
simple README.md, a more comprehensive document with a high-level architecture
of the system, API specs, whatever is necessary to help the LLM build a
reasonable approximation of the dependency graph, and figure out what subset of
integration/e2e tests seem most relevant for the change at hand.

The failure mode is that being an approximation we might skip a relevant test
that would capture a bug. Running the full e2e suite is a reasonable safety
net, but you can get away with not doing it all the time and limit them to a
fixed schedule (hourly, daily, whatever works).

Complementing this setup, usual rollout strategies (red/black, canaries, etc.),
and solid observability in production. Which should cover not just anomalies in
latency, throughput, or error rates at the service boundaries, but also
business-level metrics that catch silent functional regressions. Overall, this
hits a reasonable balance between delivery speed and early detection of
whatever issues slip through the cracks.

**Footnotes**

[^1]: I know of a FAANG where an entire business division in charge of a very-well-known product was on the spot internally for the ungodly amount of resources consumed by running e2e tests on their delivery pipelines.
