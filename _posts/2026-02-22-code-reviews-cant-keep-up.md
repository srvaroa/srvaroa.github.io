---
layout: post
title:  "Code reviews can't keep up"
date:   2026-02-22 13:00:00 +0200
excerpt: "Code review boards are clogged and the back-pressure is spreading. The goals of review -- knowledge transfer, consistency, collective ownership -- are still valid. The process that serves them is not."
categories:
---

I’m no longer convinced that the classic code review process is the
right tool for the job. 

For me, code reviews were always the prime resource for knowledge
transfer, consistency, and collective ownership of code (not for finding
bugs, that is what tests are for). I am still convinced that the goals
remain relevant, perhaps more than ever. But I am not blind. In the
teams I work with, every engineer is producing more PRs than they could
realistically review, even at early stages of AI adoption. Code review
boards are clogged with features and bug fixes, and back-pressure
propagates through the engineering team up to the business.

The argument to slow down production and spend enough time on reviews
sounds like asking to print less books because the scribbler monks can’t
keep up. The burden is on us, engineers, to figure out what needs to
change in the software production system so that we can leverage the
technology available to us.

Code reviews are an impediment because they were designed under the
assumption that software follows an artisanal mode of production. But
human labor is no longer the primary constraint. The systems we are
creating to produce software are not better shovels, they are industrial
factories and robots. So whatever replaces code reviews needs to work in
an industrial context, operate at a much higher throughput, and still
respect the same or higher level of quality, reliability, and security
standards.

As software engineers we know well enough that increasing throughput is
the easy part. The real challenge is making high throughput sustainable.
This is where knowledge transfer, consistency, and collective ownership
of code remain relevant. But we need different ways to deliver them.

---

Knowledge transfer looks different when producing software doesn't need
the classic
[pizza-team](https://aws.amazon.com/executive-insights/content/amazon-two-pizza-team/)
model with closely knit groups of 5-10 people collaborating together.
The idea of [two-slice
teams](https://every.to/chain-of-thought/the-two-slice-team) is taking
hold, and I am seeing it working well around me. One or two high-agency
engineers with a mission and LLMs.

A way to see coding agents is as a supply of throwaway hires that on can
delegate work to (including code reviews). I am not interested in
knowledge transfer to disposable hires in the same way as I was with
humans. I do care about being able to feed them a codebase, specs,
design decisions, and historical context about systems in the way that
Neo learned martial arts in Matrix.

<center><img src="https://media1.tenor.com/m/wRKrqeO4CLcAAAAd/matrix-upload.gif" /></center>

Although the concept of a knowledge cartridge uploaded to a brain in
seconds is very far from the way we’ve been preserving internal
knowledge about software: a soup of half-obsolete confluence pages,
internal wikis, and so-so commit logs doesn’t cut it. But neither does a
CLAUDE.md or AGENTS.md however cleverly written.

To review work effectively, an agent needs requirements, technical
designs,
[ADRs](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/adr-process.html),
actual API specs. Everything that a human used to internalize over
months, at an instant. When projects are split in multiple repositories,
they need an authoritative reference, providing a high level overview
and a map of actual hyperlinks. All that information needs to coexist
and evolve with the source code it describes, behind SHAs with a
high-quality commit log, giving agents critical access to the full
history and rationale of changes. The Linux kernel is a reference for
how most projects should start behaving at any scale. 

This is where I see one of the biggest gaps in infrastructure and
toolchain that slow down the transformation of the software production
systems. The blob of code, designs, and specs described above is still
too raw, and looks like a sweet spot to apply Retrieval-Augmented
Generation (RAG) for agents (and humans using them) to navigate a
codebase. Review feedback makes more sense as actual patches (either at
review time, or post-merge depending on the criticality). The automated
delivery pipeline needs built-in [Andon
cords](https://en.wikipedia.org/wiki/Andon_(manufacturing)) at different
stages to request and accomodate human intervention when necessary.
Classic UIs and CI/CD systems seem archaic for these purposes, starting
with the GitHub as the industry standard. I’m not sure that building
in-house alternatives will be the way to go.

---

Consistency doesn’t concern me as much because standards are a
precondition of industrial processes. Linters and formatters already did
much of the work, and agents write code that is ultimately a standard
distilled from reinforcement learning of an industry-wide corpus.
Consistency becomes infrastructure, not a by-product of enforcement. 

Ownership is a different matter.

## Renegotiating trust and accountability boundaries

A code review left an audit trail of responsibility over code and
outcomes. But who is responsible and accountable for the code written,
reviewed, approved, and deployed by agents? Here are AWS’s comments on
the recent [13-hour disruption related to its AI agent
Kiro](https://www.theregister.com/2026/02/20/amazon_denies_kiro_agentic_ai_behind_outage/):

> This brief event was the result of user (AWS employee) error - specifically misconfigured access controls - not AI.

It’s true that humans are generally responsible for their use of a tool,
but it feels somewhat simplistic to lay responsibility on the user of
an extraordinarily complex tool operating semi-autonomously in an
extremely complicated distributed system. People can’t reliably prompt
into correct outcomes when both are separated by a fog of
interpretations made by non-deterministic models. But then why should we
trust this code to reach production? 

Trust on modern software pipelines will come from two sources.

First, it’s obvious that the sophistication required from testing, QA
and observability are going to explode to a degree that I’m not sure
we’ve grasped yet. The dashboards, the #alerts channel, the pager, every
mechanism that expects continuous human attention are not it. But when
someone or something pulls the Andon cord and brings a human in the
loop, the complexity of [incident
management](https://surfingcomplexity.blog/2026/02/14/lots-of-ai-sre-no-ai-incident-management/)
explodes. Everything that’s going on in the industrial complex needs to
be made visible and intelligible for the human(s) that need to make
decisions at this speed.

Second, taking the real world as reference, we can see that the need for
trust and accountability led us to demand credentials to use certain
tools in certain contexts: you can’t just operate cars, heavy machinery,
aviation control towers etc. at will. At some point, the same will
happen to operate agents that are functioning autonomously in complex
software environments with non-trivial consequences at stake. 

---

The accountability point shows that even in industrial systems, humans
close the loop. We may be one or two steps removed from the factory
floor, but stay responsible for design, behaviour, and outcomes. That
requires a deep understanding of the production systems. Code reviews
were a key component of the learning experience that helped engineers
develop the domain expertise and scar tissue that are required to bear
that responsibility. We will need alternative methods to solve that
problem. We might be able to deprecate code reviews. We can’t afford to
deprecate expertise.
