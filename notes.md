# Notes

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

### Relational (PostgreSQL, SQLite)

### Columnar (ClickHouse) *analytics*

### Document (OpenSearch) - generally based on Lucene, *indexing*

#### Worriting over details: is OpenSearch a fair enough choice?

Do I need a callout to MongoDB as an actual JSON based database? - it has
different strengths, so just mentionin Lucene-based solutions may be slightly
less helpful? How much time do I want to spend on this?

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

### and as an extra, graph (Neo4J)

Why? Because Gothic and my history with an object oriented database.

30 minutes for intro/outro + 5 ideas = 30/6 = 5 minutes each.


## Appendix: But Postgres!**

> **Note** This may or may not stay in the notes. It definitely won't have
> time to be in the talk.

Of course, I'm a PostgreSQL fan, and in fact PG will let you do a lot of
things you don't expect. So this is the "but actually, you could just use
Postgres" appendix...

### Links for postgres columnar storage

* https://www.timescale.com/blog/building-columnar-compression-in-a-row-oriented-database

* https://www.citusdata.com/blog/2021/03/06/citus-10-columnar-compression-for-postgres/

* https://wiki.postgresql.org/wiki/ColumnOrientedSTorage

* https://www.tinybird.co/blog-posts/when-to-use-columnar-database

* https://www.percona.com/blog/powering-postgresql-15-with-columnar-tables/

* https://github.com/hydradatabase/columnar

* https://www.scalingpostgres.com/episodes/283-222-times-faster-analytical-queries-with-columnar-storage/

* https://www.timescale.com/blog/hypercore-a-hybrid-row-storage-engine-for-real-time-analytics

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
