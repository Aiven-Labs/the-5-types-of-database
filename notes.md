# Notes

> **Note** I'm in the "gather notes, gather links, reduce later" stage :)

## Outline

A brief introduction to the idea of databases,  and how long they've been around.

* A mention of Codd and how his ideas led to relational databases. A *very*
  brief explanation of denormalisation, the idea of references from one table
  to another, and why RDBs often "win". PostgreSQL® (the swiss army knife of
  databases) and SQLite (which is in the Python library).
* How columnar databases are arranged, and how that makes it quicker to query
  only some columns, but also the tradeoffs that requires, and why those
  tradeoffs might be worthwhile. ClickHouse®.
* How Apache Lucene™️ forms the basis for document databases, their approach to
  indexing, and why this is useful. OpenSearch®.
* Key / value stores, in memory storage, their use in caching and elsewhere,
  and how they fit the Python mind. Valkey™️.
* A brief mention of graph databases, because they're fascinating and not like
  the others. Neo4J®

And at the end a summary of what we've learnt.

## Working notes

Intro to 5 different database types and why you might choose them

> A talk lasting 30 minutes -> intro/outro + 5 ideas = 30/6 = 5 minutes each.

### The 5 kinds of database I'll look at

* Relational
* Columnar
* Document
* Key Value
* and as an extra, Graph

This sets the scene for what I'm going to do

But first, **some history** (this may or may not fit into the talk itself, but
should be kept for the notes)

### The beginnings

#### Hierarchical databases and other old stuff

In the begining were hierarchical databases.

&lt;picture of a hierarchical model - a tree structure&gt;

When I was at University, I was taught these were The Way of the Future. This
turned out not to be the case, and we shan't mention them any further...

### Codd and the invention of "relational"

(surely I can improve that title!)

* https://khotsufyan.medium.com/why-edgar-codd-came-up-with-the-relational-model-8b5ee5c47cdd -
  may or may not keep this link

* https://www.ibm.com/history/relational-database is an article giving an IBM
  view of the history. Quite short and leaves out a lot :) - probably not
  going to keep this link

* https://en.wikipedia.org/wiki/Edgar_F._Codd
* https://en.wikipedia.org/wiki/Codd%27s_12_rules (13 rules, numbered 0 to 12))

* [A Relational Model of Data for Large Shared Data
  Banks](https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf) (PDF of the
  original paper by Codd from Communications of the ACM, volume 13, number 1
  6, June 1970)

It's interesting to consider how JSON columns fit into the 12 rules (at first
glance they don't, but...). And are real, actual relational database systems
compliant with all of the rules? Do we care - perhaps we know an RDBMS when we
point at one...

Regardless, the importance of these ideas should not be ignored.

### SQL

I don't think I'll have time to make more than a passing reference to
[SQL](https://en.wikipedia.org/wiki/SQL), especially not its history.

Of course, the "What goes around" articles do talk about the ubiquity of SQL
quite a bit, and the "50 years of queries" has some useful stuff.

It *is* probably worth mentioning for each kind of database how you interact
with it for CRUD, so SQL will come in there.

...I have vague memories of (what must have been)
[QUEL](https://en.wikipedia.org/wiki/QUEL_query_languages) from when we were
using INGRES in the late 1980s / early 1990s. I don't remember finding it
any "friendlier" than SQL (we were also using Oracle at the time).

### Relational (PostgreSQL, SQLite)

  
* The databases I've chosen and why

https://en.wikipedia.org/wiki/Relational_database

https://www.postgresql.org/

> The World's Most Advanced Open Source Relational Database

and

> PostgreSQL is a powerful, open source object-relational database system with
> over 35 years of active development that has earned it a strong reputation
> for reliability, feature robustness, and performance.

Under its own license, https://www.postgresql.org/about/licence/. There's a
GitHub mirror of the source code, but that's not how it's developed - see
the https://wiki.postgresql.org/wiki/Developer_FAQ and
https://wiki.postgresql.org/wiki/Submitting_a_Patch

But also https://sqlite.org/ because it's a *library* that is packaged all
over the place (including in Python)

> SQLite is a C-language library that implements a small, fast,
> self-contained, high-reliability, full-featured, SQL database engine. SQLite
> is the most used database engine in the world.

SQLite is "public domain" - see https://sqlite.org/copyright.html - and while
it's open source, it isn't open-contribution. So that's interesting.

Meanwhile, the classic (yes, I'll say that) articles:

* [What Goes Around Comes Around... And
  Around...](https://db.cs.cmu.edu/papers/2024/whatgoesaround-sigmodrec2024.pdf)
  (PDF, 2024)
* [What Goes Around Comes
  Around][https://people.cs.umass.edu/~yanlei/courses/CS691LL-f06/papers/SH05.pdf]
  (PDF, 2005) from the 4th edition of Readings in Database Systems ("the Red
  Book")
  
  (alternative
  source)[https://people.csail.mit.edu/tdanford/6830papers/stonebraker-what-goes-around.pdf]
  
  (alternative source)[https://dsf.berkeley.edu/cs286/papers/goesaround-redbook2005.pdf]
  
The earlier starts with some interesting history of how modern database systems
got started, and both are essential (if biassed!) reading, and the latter
continues. Between them, they may describe as many as 23 different "kinds" of
database, although that's taking a maximal approach, and folding "types of
system" into "architectures". (I could do with rethinking that number, but the
"shock value" of it is quite nice, even if it's wrong!)

Other notes:

* https://architecturenotes.co/p/things-you-should-know-about-databases is
  rather nice, although mostly about the workings of indexes and transactions
* Two nice linked pieces by Kat Cosgrove and Matty Stratton

  * https://thenewstack.io/a-brief-devops-history-databases-to-infinity-and-beyond/
  * https://thenewstack.io/a-brief-devops-history-databases-to-infinity-and-beyond-part-2/

* From 2024, this piece is nice:
  https://matt.blwt.io/post/7-databases-in-7-weeks-for-2025/ - PG, SQLite,
  DuckDB, ClickHouse, FoundationDB, TigerBeetle, CockroachDB - and it is
  inspired by the book [Seven Databases in Seven Weeks: A Guide to Modern
  Databases and the NoSQL Movement](https://7dbs.io/) from 2019, by Luc
  Perkins, Eric Redmond, and Jim Wilson, which has a sort-of similar idea to
  mine, with PG, HBase, MongoDB/CouchDB, DynamoDB/Redis and Neo4J - indeed,
  although it's from 2019, and thus the databases chosen are not the same, it
  still looks interesting enough that I've bought a copy to read (I've thought
  this before when seeing the book, but never quite committed! - I think the
  professed "NoSQL" angle turned me off a bit, but the preview of the book
  seems sound.)
  
* [50 Years of Queries](https://cacm.acm.org/research/50-years-of-queries/),
  2024, Donald  Chamberlin, Communications of the ACM website (under "Computer
  History") - written by someone who remembers, having started at IBM Yorktown
  in 1970. I really like this article.
  
  Note it also talks to SQL, its history, and its "style"
  
-----

&lt;picture of a table&gt;

&lt;picture of two tables with a join shown as an arrow&gt;

&lt;a schema?&gt;

### Columnar (ClickHouse) *analytics*

https://github.com/ClickHouse/ClickHouse (Apache v2.0)

> ClickHouse® is a real-time analytics database management system

https://clickhouse.com/

> The fastest analytical database for ...

Obviously there are also commeercial offerings

* Interesting: https://clickhouse.com/blog/a-new-powerful-json-data-type-for-clickhouse


### Document (OpenSearch) - generally based on Lucene, *indexing*

When I think of "document" databases, I think of Lucene based services, with
that concentration on "indexing all the things". So OpenSearch is my obvious
choice here.

https://opensearch.org/

> Find the meaning in your data
>
> OpenSearch is an open-source, enterprise-grade search and observability
> suite that brings order to unstructured data at scale

However, I could understand that people might think first of something like
MongoDB, which is (essentially) JSON based. Should I mention this? Do I have
enough time to anything useful (or is there a one sentence summary I can use
to refer people to MongoDB if that's their actual need)?

https://www.mongodb.com/

Note: [FerretDB](https://blog.ferretdb.io/) gives "MongoDB" on top of PG. Version 2 is based on
[DocumentDB](https://github.com/microsoft/documentdb) from Microsoft, itself
[now open
sourced](https://opensource.microsoft.com/blog/2025/01/23/documentdb-open-source-announcement/)
(it's MIT licensed).

Some quick googling gives:

* 2024 [MongoDB vs. Lucene: A Comparative Analysis for Data Management](https://www.sprinkledata.com/blogs/mongodb-vs-lucene-a-comparative-analysis-for-data-management)
* 2024 [Elasticsearch vs MongoDB - Battle of Search and
  Store](https://signoz.io/blog/elasticsearch-vs-mongodb/)
* 2024 [9 MongoDB Alternatives To Consider (And When To Use
  Each)](https://www.cloudzero.com/blog/mongodb-alternatives/) - although this
  gets a *bit* far ranging!

and I'm sure there's other good stuff to consider.

### Key Value (Valkey) *caching* (and more!)

...but also think Python dictionaries

https://valkey.io/

> FAST. RELIABLE. OPEN SOURCE, FOREVER.
>
> Valkey is an open source (BSD) high-performance key/value datastore that
> supports a variety of workloads such as caching, message queues, and can act
> as a primary database. The project is backed by the Linux Foundation,
> ensuring it will remain open source forever.



### and as an extra, graph (Neo4J)

Why? Because Gothic and my history with an object oriented database.

https://neo4j.com/

> Neo4j, the world's most-loved graph database

https://neo4j.com/product/neo4j-graph-database/

https://github.com/neo4j -> https://github.com/neo4j/neo4j (GPL3 license)

(there's also an enterprise edition)

### What we've looked at

Five different kinds (shapes) of database

* Relational (PostgreSQL®, SQLite)
* Columnar (ClickHouse®)
* Document (OpenSearch®)
* Key Value (Valkey™️)
* and as an extra, Graph (Neo4J®)

Questions for the audience (and for discussion afterwards):

* Do they agree with that way of splitting up databases?
* Do they think I've missed something important?

## Appendix: But Postgres!**

> **Note** This may or may not stay in the notes. It definitely won't have
> time to be in the talk.

Of course, I'm a PostgreSQL fan, and in fact PG will let you do a lot of
things you don't expect. So this is the "but actually, you could just use
Postgres" appendix...

### Links for Postgres as a relational database

* https://www.postgresql.org/

(Yes, including this section is a joke, because clearly PG fits!)

### Links for postgres columnar storage

* https://www.timescale.com/blog/building-columnar-compression-in-a-row-oriented-database

* https://www.citusdata.com/blog/2021/03/06/citus-10-columnar-compression-for-postgres/

* https://wiki.postgresql.org/wiki/ColumnOrientedSTorage

* https://www.tinybird.co/blog-posts/when-to-use-columnar-database

* https://www.percona.com/blog/powering-postgresql-15-with-columnar-tables/

* https://github.com/hydradatabase/columnar

* https://www.scalingpostgres.com/episodes/283-222-times-faster-analytical-queries-with-columnar-storage/

* https://www.timescale.com/blog/hypercore-a-hybrid-row-storage-engine-for-real-time-analytics

Also note that Google's (not open source) AlloyDB Omni, which is based on
PostgreSQL, has support for a columnar in-memory data view. See
https://cloud.google.com/products/alloydb?hl=en#analytical-workloads and
https://cloud.google.com/blog/products/databases/alloydb-for-postgresql-columnar-engine

I mention it because (a) it's interesting and (b) Aiven offers a managed
version of it on the three hyperscalers, which is an interesting experiment
given our normal preference for actual open source solutions.

### Links for postgres document database

* https://www.reddit.com/r/Database/comments/wbc1yq/postgres_as_document_db_vs_mongo/

* https://www.theregister.com/2025/01/27/microsoft_builds_open_source_document/

* https://documentdatabase.org/blog/postgres-doc-storage/

* https://medium.com/@mounika.polabathina/postgres-nosql-vs-mongodb-the-verdict-5b90fd348e9d

* https://www.pluralsight.com/courses/postgresql-document-database

* https://www.ferretdb.com/

* https://opensource.microsoft.com/blog/2025/01/23/documentdb-open-source-announcement/

* https://martendb.io/

### Links for postgres as key value store

* https://medium.com/database-dive/fast-key-value-store-with-postgresql-ebac3cd76d9b

* https://www.reddit.com/r/PostgreSQL/comments/w9l5r0/is_postgres_a_good_keyvalue_store/?rdt=60736

* https://www.postgresql.org/docs/current/hstore.html

* and re GIS and "object oriented" and Gothic: https://postgis.net/docs/manual-3.5/Topology.html

### Links for postgres graph database

* https://xd04.medium.com/using-postgresql-as-a-graph-database-a-simple-approach-for-beginners-c76d3bc9e82c

* https://news.ycombinator.com/item?id=35386948 -- Postgres as a graph
  database (dylanpaulus.com)
  
  * https://www.dylanpaulus.com/posts/postgres-is-a-graph-database/
  
* https://www.alibabacloud.com/blog/postgresql-graph-search-practices---10-billion-scale-graph-with-millisecond-response_595039

* https://hoverbear.org/blog/postgresql-hierarchical-structures/

* https://news.ycombinator.com/item?id=43198520 -- Postgres as a Graph
  Database: (Ab)Using PgRouting (supabase.com)
  
* https://www.hillelwayne.com/post/graph-types/

* https://www.puppygraph.com/blog/postgresql-graph-database

* https://age.apache.org/ and https://age.apache.org/faq/

* https://www.geldata.com/ (what was EdgeDB)

But, of course, for my *original* use case, digital mapping

* https://postgis.net/
