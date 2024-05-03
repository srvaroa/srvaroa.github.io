---
layout: post
title:  "Identifiers are better off without meaning"
date:   2024-05-02 00:01:00 +0200
categories:
---

Once at [Last.fm](httpf://last.fm) we had an integer overflow in an
identify field. I can't recall where exactly. But I do remember that
the inconvenience of having a bunch of Hadoop jobs disrupted while we
rushed to update the relevant type couldn't spoil the collective pride
for having more than 2 billion of whatever needed so many ids.

Being frugal with identifiers is seldom a good idea, but for me the
worst identifier-related headaches came from IDs that had semantic
value.

At [Tuenti](https://en.wikipedia.org/wiki/Tuenti) (once the largest
social network in Spain) there was a concept similar to Facebook pages.
Pages had types and subtypes. A page type might have been "group", which
had subtypes "business" or "community". Another type could be "place"
with subtypes like "store" or "landmark".

Page identifiers were strings composed by concatenating numeric
identifiers of the type, subtype, and then an increment field in a DB.
If you visited `https://tuenti.com/p/3_2_6691` you'd instantly know
the meaning. It was a "place" (3) of type "store" (2), and the store ID
was 6691. Page IDs decomposed in this way would be useful for multiple
purposes.  Chosing a type-specific implementation of controllers to
compose the relevant page, routing to a database shard, that kind of
thing.

At some point Product wanted to change the classification of pages. To
their frustration, this became problematic because the entire taxonomy
was encrusted across the code all the way from URLs to databases.

Another example are [New Relic
entities](https://docs.newrelic.com/docs/new-relic-solutions/new-relic-one/core-concepts/what-entity-new-relic/#entity-synthesis).
Entities are an abstraction that broadly represents anything that can
send telemetry to New Relic. A host, a Kubernetes cluster, an
application, a JVM or a network router can be entities. Of course those
are all things you want to identify, so entities have Global Unique
IDentifier, or GUID. Every single telemetry datapoint is stamped with
the GUID of the entity that produced it, so they act as the keystone of
the New Relic platform. Features like Service maps, distributed tracing,
entity relationships, and many others are built upon them.

[Entity GUIDs have
meaning](https://github.com/newrelic/entity-definitions/blob/main/docs/entities/guid_spec.md).
An example of a GUID is `1|APM|APPLICATION|23` where 1 is the account,
`APM` is the domain, `APPLICATION` is the unique type within that
domain, and `23` is a unique identifier within the domain and type. That
application might be running in a host `1|INFRA|HOST|12`. If we wanted
to store that relation, we'd have an entry in some database saying:

`"1|INFRA|HOST|12" RUNS "1|APM|APPLICATION|23"`.

Like at Tuenti, these semantics come handy. If you're processing
millions of telemetry datapoints per second, it's useful to tell the
type of reporting entity on the fly by decomposing the GUID, rather than
perform an expensive lookup to an external service. Account IDs can be
used to route data to cells ([this talk from Andrew
Bloomgarden](https://www.youtube.com/watch?app=desktop&v=eMikCXiBlOA)
explains how NR used this pattern to scale).

Domains like `INFRA` or `APM` corresponded to the original product
verticals at New Relic. Years later Product decided (with good criteria)
that they created unnecessary fragmentation on the user experience.
Types change, get renamed or merged with others.  Sometimes (more often
than it seems) entities had to migrate from one account to another. In
all these cases you would be altering the identifier of many entities.

It was painful but possible to work around many of these problems. But
replacing GUIDs with semantic-free identifers was straight impossible.
By virtue of being present in thousands of URLs, NRQL queries, etc.
GUIDs had become a public API that thousands of customers relied upon. A
technical solution to replace identifiers would have been a major
project, but doable. What wasn't possible was to run a find/replace
across the private documentation and workflows of your entire customer
base.

If you look closely, the world is full of semantic identifiers. They are
almost invariably a pain in the neck because they embed a specific model
of the world. But models become obsolete faster than we'd like.

Addresses make notable examples. The "complex and idiosyncratic"
[Japanese address
system](https://en.wikipedia.org/wiki/Japanese_addressing_system)
reflects the organic growth of its urban areas. In [British postal
codes](https://en.wikipedia.org/wiki/Postcodes_in_the_United_Kingdom#Overview)
the final part can designate anything from a street to a flat depending
on the amount of mail received by the premises. 

When I was a kid, license plates would give up the province where the
owner lived causing an [array of
nuisances](https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Spain#1900_to_1970).
They were alleviated with the adoption of [European
standards](https://en.wikipedia.org/wiki/European_vehicle_registration_plate#European_Union).
But partly. The root problem being that, like the [Domain Name
System](https://en.wikipedia.org/wiki/Domain_Name_System) they tie
identifiers ("Galo's website") remain tied to administrative authorities
(".net") who can change regulations, or even disappear.

Nowadays I find most semantic identifiers in resource management. For
some reason, when infrastructure teams define access rules to the
resources of a particular service, they prefer to create a group named
after the team that owns that service, something like
"owner-team-access-list". Identifiers tied to the org chart don't like
it when the service moves to another team, or owner-team is reorged
away.
