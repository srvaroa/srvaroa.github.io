---
layout: post
title:  "How about we forget test types?"
date:   2024-02-06 23:00:00 +0200
categories:
---

I have found that the concept of test types (unit, integration, and so
on) does more harm than good. People often give me odd looks when I say
this, so having the explanation in a URL will come handy for future
reference. I will use it as an introduction to a series of practical
case studies on the topic of testing software.

<hr />

Test types shape the way engineers and even adjacent professionals
reason about testing software. This goes far beyond how an engineer may
decide to test a single change. It also influences how teams and entire
organisations analyse, design, implement, and evolve their testing
pipelines. Which is no joke, given that test writing, test
infrastructure, and test tooling accounts for around 30-40% of the cost
of maintaining software (ChatGPT or Google queries are consistent in
that ballpark, which roughly matches my experience). This cost is well
justified by the impact of testing on any company whose product depends
on building software.

Imagine you’re in one of those organisations. It might be new, and
growing. How do you structure the testing pipelines, the infrastructure,
the principles and “best practices” that govern work inside each
individual engineering team and across them. How do you find the right
balance between quality and velocity? Do we need a QA team? How will all
those elements behave when growing pains appear? Will they adapt and
keep up with the business, or will your engineering machinery grind to a
halt?

What happens if the organisation was consolidated, and already at that
breaking point? Suffering quality issues, slow development, gruelling
and unpredictable delivery cycles. How do you approach the task of
improving the quality of the overall product, and each of its
components? How do you identify the necessary changes in the existing
testing pipeline? How do you convince leadership to fund them? How do
you execute those changes without disrupting the business? When these
changes impact the way product teams develop, test, and distribute their
software, how do we exercise an effective influence on their (likely
reluctant) engineers, their tech leads, their engineering and product
managers? What type of shared testing infrastructure needs to be built
to support all those teams, and which should never be built, even if
teams ask for it? Was there a QA team already? Does their role change?
How different are the analysis and the solutions if the product is not
just a web site with a bunch of server-side components, but also has a
mobile application, or native ones, or firmware? How do we know if we’re
making progress?

Having solid foundations to reason about your testing is essential to
answer any of those questions.

Test types consolidated on that foundational role when Michael Cohn
introduced the Test Pyramid in “[Succeeding with
Agile](https://www.amazon.es/Succeeding-Agile-Software-Development-Using/dp/0321579364?&linkCode=ll1&tag=avr0b-21&linkId=76908430c11232694d8007c9d428887b&language=es_ES&ref_=as_li_ss_tl)”
(2010). The key concept it put in the collective mindset was that you
can classify tests in types which are then laid down as layers. Bottom
to top these were ”unit”, “service” (nowadays perhaps more commonly
known as “integration”), and “user interface”. You want to have more of
the lower ones, fewer of the upper ones.

Here is [Cohn
himself](https://www.mountaingoatsoftware.com/blog/the-forgotten-layer-of-the-test-automation-pyramid):

<blockquote>
"At the base of the test automation pyramid is unit testing. Unit
testing should be the foundation of a solid test automation strategy and
as such represents the largest part of the pyramid. Automated unit tests
are wonderful because [...]"
</blockquote>

This says something about their importance relative to other types but
nothing about how to distinguish them. I couldn’t find a clearer
definition in “Succeeding with Agile”. In my experience, when people
talk about unit tests they imply a focus on verifying a narrow surface
of a code base, although it’s unclear how narrow.
[Wikipedia](https://en.wikipedia.org/wiki/Unit_testing) says that a
“*Unit is the smallest component that can be isolated within the complex
structure of an app. It could be a function, a subroutine, a method or
property*”, but it comes along with a "`citation needed`" and if I take
that definition seriously, then Cohn’s later point that Service testing
“fill[s] the gap between unit and user interface testing” sounds like
defining water surfaces as “ponds” and “everything else”.

So let’s consult more consultants. Martin Fowler explains that when
writing unit tests at C3 they would “set up a test fixture that created
that object with all the necessary dependencies so it could execute its
methods.” Now we seem to be at the granularity of an object. But in the
same explanation he [provides a
quote](https://martinfowler.com/articles/2021-test-shapes.html) from
Kent Beck’s [Extreme
Programming](https://www.amazon.com/Extreme-Programming-Explained-Embrace-Change/dp/0321278658?crid=2Q9PJD594CD0M&keywords=extreme+programming+kent+beck&qid=1704621833&s=books&sprefix=extreme+programming+kent+be%2Cstripbooks-intl-ship%2C259&sr=1-1&linkCode=ll1&tag=avr0b-20&linkId=f6e4c6e224d48f82be27de28db318fd5&language=en_US&ref_=as_li_ss_tl),
which Fowler reads as meaning that “*’unit test’ means anything written
by the programmers as opposed to a separate testing team*”.

That scope seems panoramic compared with “*the smaller component that
can be isolated within […] an app*” that we read in Wikipedia and many
other sources. Besides, linking the type of test to who writes it is
also problematic: I know of many organisations where programmers write
most tests, even those that verify large areas of the system or the UI.
Does this mean that tests will be “unit” in one company but not in
another?

According to Martin Fowler, [there
was](https://martinfowler.com/articles/2021-test-shapes.html)
“considerable discussion” about Kent Beck’s formulation to the point
that “*one test expert vigorously lambasted Kent for his usage*”. They
asked the expert for his definition of unit testing and he replied that
"*in the first morning of my training course I cover 24 different
definitions of unit test.*”

<hr />

We can’t expect much of a conceptual framework based on test types when
the key terms, in Fowler’s own words, “*have always been rather murky,
even by the slippery standards of most software terminology*”. It
certainly explains why using them in any conversation about testing
among engineers works like the proverbial can of worms. Once you open
it, the slimy creeps cause trouble everywhere. 

But it’s worse than that. If engineers can’t have a meaningful
conversation about testing, then the communication with business
stakeholders about quality and software delivery is doomed to be nothing
but dysfunctional.

I have seen my share of the consequences. Organisations that take the
pyramid at heart and over invest on the basis with a multitude of hyper
granular unit tests for individual functions and methods. They run into
the law of diminishing returns. Issues proliferate at the articulation
between pieces that were considered individually correct. Business
stakeholders are unimpressed by the high coverage number and would
rather see the product work after assembling the pieces. The “[two unit
tests, zero integration
tests](https://www.reddit.com/r/ProgrammerHumor/comments/dw8s1i/2_unit_tests_0_integration_tests/)”
memes circulate. Teams get burnt by those problems, some dismiss unit
tests as “encumbering and superficial” and conclude that [unit testing
is overrated](https://news.ycombinator.com/item?id=30942020). They
decide that they need less of that type, and more of the comprehensive
types that exercise complete use cases across wider surfaces of the
system. A good amount of those teams later end up buried under the
weight of byzantine test infrastructures that silently grew slow and
unscalable in technical, organisational, or both dimensions. In the
meantime business grows more and more frustrated with the slow pace of
delivery.

All the way through this mess, people try to figure out what went wrong.
They have opinionated debates around the company’s or the internet’s
water cooler that seldom reach a conclusion. Maybe the problem is in the
choice of shape? What if [the Pyramid has fallen out of
style](https://twitter.com/swyx/status/1261202288476971008)? Perhaps we
should get more creative. Let’s try the [Test
Trophy](https://thetestingarchitect.substack.com/p/test-pyramid-test-honeycomb-test).
[The Test
Honeycomb](https://engineering.atspotify.com/2018/01/testing-of-microservices/).
[The Test Diamond](https://web.dev/articles/ta-strategies). [The Test
Crab](https://web.dev/articles/ta-strategies). We were not able to
define one type properly but why not add more? Component tests. API
tests. Fowler himself proposes [Subcutaneous
tests](https://martinfowler.com/bliki/SubcutaneousTest.html), [Broad
stack tests](https://martinfowler.com/bliki/BroadStackTest.html),
[Solitary and Sociable
tests](https://martinfowler.com/bliki/UnitTest.html). Sometimes they
depend on how much surface of code is touched. Others it’s on how that
code is structured. On what part of the stack the code belongs to. How
are tests written, or who writes them.  Anything goes.

The whole thing reminds of Borges’ [Celestial Emporium of Benevolent
Knowledge](https://en.wikipedia.org/wiki/Celestial_Emporium_of_Benevolent_Knowledge).
All are valid classifications, none authoritative, and their utility
limited to some. Which is fine for certain topics. But when it comes
about testing software it seems that the importance of the subject would
deserve, if not demand, that software engineers have a solid vocabulary
to hold a rational conversation, among themselves and with stakeholders.

<div class="image-box">
  <img
    src="{{site.baseurl}}/assets/test_types/wooden_shapes.png"
    alt="A shape sorting toy made out of wood, with coloured pieces"/>
</div>

How about we stop being content with “slippery standards” on our
professional terminology and pay less attention to these murky terms?
What if instead, we focus on what we want to achieve and frame the
problem as what it is: a system. After all a test pipeline is just that,
a system whose inputs are code and related artefacts produced by
development teams, and whose function is to give as much confidence as
possible on whether they work as expected. We want this system to remain
efficient, performant, cost-effective, and scalable to keep up with the
needs of the business. The usual drill.

With this approach the problem stops being about shoehorning the
complexity of modern software in awkwardly shaped geometric ideals that
fit someone’s wooden box. Instead, we are designing a system with a
clear purpose. We are doing engineering.

What do we find if we look at a testing pipeline from a systems
perspective? Well, one can think about three basic, familiar properties
we always care about: latency, throughput, error rate.

* Latency tells us how long it takes to verify a given change, to run a
  test, or the full test suite. It measures the length of our feedback
  loops.
* Throughput tells us how many of those verifications I can run per unit
  of time.
* Error rate tells us what percentage of test executions fail to do
  their job. Note that this is not the same as failed tests (that is a
  successful execution!). Errors would be false positives (regressions
  that slip through our safety net), or false positives (often flakes).

These are not ground breaking ideas! They permeate the literature about
software testing in one form or another (the reason for preferring unit
tests boils down to trade-offs around latency, error rate, throughput).
But for some reason types, categories, and shapes take the spotlight and
dominate the discussion. Bringing back the focus to the domain of
systems design rather than abstract classification games, helps reason
about problems around testing much more productively.

As I mentioned above this is meant to be an introduction to a short
series of posts about testing software. The next posts will be practical
applications of a systems perspective:

* Analyze a testing pipeline with multiple teams involved, which suffers
  many of the pathologies described above. It will be based on real
  examples that I have found in the wild. I will model these pipelines
  as an actual system and show how this gives us a much better
  understanding of what we can do to improve the situation.
* Show concrete interventions that can be implemented, from the
  individual team level to the larger organisation, and use our model of
  the system to observe and measure the impact. I will also try to
  reference real work done in some of the companies I've worked with.

I'm curious about how people design their own testing pipelines,
challenges, and useful patterns, so anything you want to share will be
very welcome.
