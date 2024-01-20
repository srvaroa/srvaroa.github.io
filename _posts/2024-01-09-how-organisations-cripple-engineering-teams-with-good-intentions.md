---
layout: post
title:  "How organisations cripple engineering teams with good intentions"
date:   2024-01-09 13:00:00 +0200
categories:
---

I believe that engineers are at their best when they complement strong
technical expertise with skills from other disciplines such as product,
project and people management, customer support, HR, finance, UX, and
many others. I believe that any software engineer should structure their
growth plan to acquire the basics of some of those disciplines. I
recommend undergoing a [tour of
duty](https://charity.wtf/2019/01/04/engineering-management-the-pendulum-or-the-ladder/)
wearing one of those hats. 

I also believe that engineering teams are better when they are not
limited to executing technical work, but also understand why. Engineers
power-up when they have a clear understanding of the business and
product strategy. When they are involved with other domain experts
(product, project, people managers, customer support, HR, finance, UX,
etc.) in designing the organisational structure and processes that
govern their day-to-day technical work.

Some may disagree with this. That's fine, but that'd be a different
discussion. Here I assume that we agree on those points, and therefore
we should want to design organisations to pursue those goals. Where
engineers are supported and encouraged to develop a diverse toolbox of
skills from other disciplines, and where engineers are supported and
encouraged to participate in more aspects of the business than merely
typing code.

Here I want to discuss how attempts to implement these worthy objectives
often backfire.

<hr />

Let me present a simplified version of a pattern I’ve witnessed a few
times.

* Leadership learns from product manager feedback that technical
  decisions are not well aligned with user needs. They diagnose
  (rightly) that engineering is not close enough to the user. Since we
  have an interest in augmenting engineers with product management
  skills, it seems like a good idea to introduce a change in the
  organisation’s processes so that engineers spend more quality time
  with PMs and customers when defining epics / stories. It's hard to
  argue with this! It makes total sense.
* Some time later UX designers raise that the software is disconnected
  from the actual user experience. After a similar analysis, it seems
  like a good idea to modify our processes to allow engineers to spend
  more quality time with UX designers when designing features. Again,
  it's hard to argue with this! It makes total sense.
* Some time later leadership notices that project management work is
  falling through the organisational cracks which harms delivery,
  quality, etc. They realise that this is a good opportunity to help
  engineers develop their project management skills, so we incorporate
  some project management responsibilities into engineering teams.
  Again, this makes sense!
* Then leadership meets with Customer Support.
* Then, with Sales.

You see where I'm going, right?

Here is a simplified version of another common pattern.

* Product stakeholders are defining product priorities for the quarter.
  We want an inclusive work environment where any engineer can
  contribute ideas for the product. This all makes sense, so we ask the
  managers to work with their teams in proposing ideas for initiatives
  and projects.
* HR are looking to improve social media presence and attract leads to
  the hiring pipeline. Having Engineer-generated content in the
  corporate blog would be powerful! It also helps engineers build
  writing skills, get a public presence. Let’s ask engineers to write!
* Hiring processes are about to be redefined. We dig inclusiveness. We
  want engineers engaged and involved. The hiring managers and HR ask
  teams to get the engineering hive mind to work and crunch some
  proposals.
* Customer support needs new standards, some consolidation of processes
  and tools.  Engineer feedback and engagement is valuable! We ask each
  team’s manager to collect feedback and ideas from their teams.
* And so on.

<h2>A sum of individual good ideas doesn’t guarantee a good outcome</h2>

It’s a common mistake to assume that by adding up rational individual
decisions you get to a good aggregate outcome. It’s usually the
opposite. In an evacuation, running for the exit is a sensible
individual decision, but aggregate them and you get a lethal stampede. 

Something similar happens in our little stories. Making process changes
to bring PM, UX, Customer Support, etc. closer to engineers, or asking
engineering teams to propose ideas for organisational aspects makes
sense as individual decisions. But put together, they can have bad
consequences which harm engineering teams (and by extension, the larger
organisation). As we implement them, we suddenly realise that engineers
barely spend time in actual engineering.

Now, I know this is a trigger for many people. They think. "Hah! Here we
go again! An engineer arguing that engineers should be left alone with
the code". This is not what I’m saying (I said the very opposite in the
first paragraph!). But my strong belief in multi dimensional engineers
that are engaged with the larger organisation is compatible with the
belief that engineers should spend most of their time in engineering. 

That statement is not even controversial if you swap industries. Think
construction. There is value in bricklayers, plumbers, electricians,
designers and architects knowing some of each other's skills. Still,
bricklayers must spend a substantial amount of their time laying bricks.
Electricians wiring. Plumbers plumbing. Architects architecting. Or else
the building won’t get done.

Software engineering is not different. Engineers need to spend time
doing engineering. Who else will do the technical designs, write,
review, test, operate software?

A more measured objection to my point is to accept that while engineers
should spend time engineering, they should still spend some of their
time in activities outside of their core expertise area. Sure. I agree.
But “some” is quite broad. Let's be more precise. What % of time spent
in core engineering activities are we talking about? 50%? 25%? Give me a
ballpark. 

<h2>Minimum reasonable focus</h2>

Or rather, let’s change places. What is the minimum % of time in
activities not related to the core expertise that you consider
reasonable for your own role? What is the minimum % of time that a PM
should spend on product management tasks? Is 50% reasonable or does it
seem too low? It does sound low to me! Isn’t it more like 70%? Would it
be reasonable for a UX designer to spend less than 70% of their time in
core UX design activities? What about people managers? Customer Support?

But let’s go further. I guess we agree that multi dimensionality also
applies to non-engineering disciplines: that they are also enriched by
acquiring the basics of engineering (among others). So let me ask the
PMs, UX designers, People Managers, HR, Sales and customer support folks
in the room. What % of your time do you spend doing core engineering
activities like code, tests, code reviews, technical documents,
operations and so on. I am fairly confident that if I take the average
of this poll, it would round up to low single digits. That sounds
reasonable! But doesn’t that mean that having engineers spend low
single-digit %s of their time on those non-engineering activities is
also reasonable?

Building a house needs bricklayers, architects, plumbers, designers,
electricians, and so on. All matter. All are valuable. All benefit from
learning the basics about the other’s expertise area. And yet, plumbers
spend most of their time plumbing. The many experts involved in building
software are in exactly the same situation. All matter. All are
valuable. All are richer when they learn the basics of the other’s
expertise area. And yet, all need to dedicate a substantial % of their
focus and dedication to their core activities. 

We can now go back to that sequence of individual, rational, sound
decisions that the leaders who design organisations tend to make. Of
course it’s great to design organisations that help engineers acquire a
diverse set of skills, that they engage with defining strategy,
organisation, process. But because time is limited, we must be conscious
that every time we direct an engineer's attention away from engineering,
we’re chipping away from that minimum reasonable allocation of time that
they, like any other professional, need for their core activities. I
reiterate that this is not just writing code. It’s also about code
reviews, technical designs, and so on. I struggle to see a minimum
reasonable allocation for those core engineering activities of less than
70%.

You might think that a budget of 30% non-engineering time doesn’t seem
so bad. It’s 12h in a standard 40h week! It can fit a lot of stuff.

But notice that we didn’t even talk about the baseline of day-to-day
overhead that goes into every individual engineering team. I’m thinking
of activities involved in backlog grooming or ordinary human
coordination that already consume a good chunk of that non-engineering
budget. Those activities tend to be inflated with a proliferation of
rituals, meetings, paperwork, rich in post-its and generally under the
umbrella of a methodology, that go well beyond the necessary to achieve
their purpose with pragmatism. Not much is left of those 12h.

Project/product/people management specialists easily overlook that
overhead and inflation because, from their perspective, that time seems
well spent (engineers are project managing! Growing multi disciplinary
skills! Applying the latest methodologies! Good stuff!) But what happens
if we now add some time working on requirement gathering? And on
    customer support? And on designing interfaces? And on pitching
    project ideas? And writing posts for the corporate blog? Great
    learning! Inclusiveness! But Ars longa, vita brevis. Engineers spend
    less time in engineering.

Would you, product manager, people manager, UX designer,
`$insert_your_discipline_here`, be able to do your job properly if you
had to spend 5% of your time in each of 10 other disciplines? If your
core activity was loaded with a crust of unnecessary ritual? Of course
not!

## Work fragmentation hurts engineers

There is a factor that makes this problem even worse in engineering (as
well as in other disciplines). I will refer here to the well-known
[Maker’s schedule, Manager’s schedule](http://paulgraham.com/makersschedule.html). An engineer’s
schedule is like a glass jar that you want to fill with stones, pebbles
and sand. You can only succeed in that exact order. If you try to put
the pebbles and sand first, the stones won’t fit. Maker-type work is
primarily like stones, it requires solid blocks of uninterrupted time.
Manager-type work is mostly like sand or pebbles, it can fit in a more
fragmented schedule with small blocks of time. Maker schedules don’t
work like that: it’s not just a matter of how much time is spent in
non-engineering work. It’s also the fragmentation. Put diverse, varied
activities into an engineering team and the quality of the engineering
will go down because the engineering rocks won’t fit. This isn’t to say
that Manager-type work is less important! It’s equally important! But
they are different jobs for reasons like this one.

<h2>Consequences</h2>

When the minimum reasonable threshold of time dedicated to core
engineering tasks is broken, things backfire. I’ve seen this in two main
varieties:

### Teams neglect their engineering standards. 

This is unsurprising if they don’t have time because they are doing too
much work in adjacent expertise areas, like figuring out requirements,
talking to customers, writing blog posts, or having meeting after
meeting to push JIRAs around. Of course all those activities are
important. Of course engineers grow by doing those activities. Of course
they should individually do them at some point in their careers. But
time available for those is relatively small. They can’t do all, plus
engineering at the right standards. It just can’t happen. 

The amount of time matters. But for engineers and other maker roles,
so does fragmentation. Put diverse, varied activities into an
engineering team and the quality of the engineering will go down.
The engineering rocks won’t fit. 

### It burns people out.

On one hand, red tape and bureaucracy are well known demotivators for
engineers (“I could fix this in less time than I write the JIRAs”). On
the other hand, we have seen quite a few instances of the following
pattern. A gap appears in the people management / product management /
project management area. Senior engineer is spotted as capable of
plugging that hole. The engineer’s manager makes the case that taking
those activities will broaden their toolbox. This makes sense! Engineer
accepts. Does less engineering, more people/product/project management.
Gradually, no engineering. Some of these people become happy project,
product or people managers. But a good chunk of those end up stuck in a
position they don’t quite enjoy, not knowing how to go back, constrained
by a web of pressure points (e.g. lack of equally clear growth plan in
the engineering track as for management roles), until they burn out and
interview elsewhere for an engineering position. And yes, they now shine
as a multi-dimensional engineer. But shine elsewhere.

Both are bad outcomes for the organisation, even if they derive from an
accumulation of individual decisions that are rational and hard to
disagree with.

## So I guess I have two messages

### First, to leaders and managers outside of engineering.

We are all aligned on the value of multidimensional engineers, on
transparency, on inclusiveness. You should design your organisation
accordingly.  Sometimes, engineers will have to be strong-armed against
their will or their preference! Many times, the “we have project
management work that’s falling through the cracks” or “we need UX and
engineering to be closer” serve as great opportunities to learn the
basics. All that is welcome.

But please, you need to balance this with an awareness that time matters
and context matters. That you cannot have engineers participate in
product and project management, UX, HR, customer support and three more
things at the same time, as part of their day to day, full-time job as
engineer. That sometimes yes, it’d be great to have engineers join
sales, or HR, or customer support, or something else, but this is
incompatible with keeping a “maker schedule” that is vital to healthy
engineering. That involving the team in that well-intentioned
brainstorming session to figure out the next quarter’s priorities can
disable the same team from delivering the last quarter’s goals up to the
right standards. That sometimes, if there is a hole in <some_discipline>
work, maybe the solution is not to throw an engineer at the problem, but
rather go and get the <discipline_domain_experts> to plug it. That you
may be interested in old or new methodologies, tools of your trade, etc.
but introducing them in engineering teams may inflate the amount of
non-engineering time they have to deal with unnecessarily, to the
detriment of the time available for their core responsibility.

That all of this does not mean devaluing your discipline. It just means
that engineering is a different one.

### Second, to Individual Contributors in engineering leadership roles.

You have to convey to engineers around you the importance of
understanding the Why of your work. The value of growing a diverse
toolbox of skills. Be a role model in this. Help them engage with the
business. Push them to get out of the code sometime, and walk the
organisation learning what’s beyond the brick laying. To get into the
project manager or the UX designer’s shoes, to go help customers ensure
that disaster of an API we designed behind our noise-cancelling
headphones. To do the project management that’s falling through the
cracks, and learn from the experience.

This is all essential. But it is equally essential that you help
engineers keep their focus, attention, raw, solid, uninterrupted quality
time, on core engineering activities. Ensure that their jars fill with
big stones first. Sometimes you do this by pushing back when the
organisation wants to use some of the engineer’s time budget into for
purposes that seem good, well motivated and rational, but can have
unintentional side effects on the engineers’ ability to write, review,
operate, deliver and maintain the engineering dimension of high quality
software up to high standards.

This doesn’t mean that engineering is the only dimension that matters.
Nor that it’s the most important one.  Nor should you think of yourself
and your team as sacred cows among lesser professionals.

It just means that you’re engineers, and you have a job to do.

