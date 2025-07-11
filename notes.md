# Notes

## Abstract (repeated from the README)

What database should you choose? Worse, what *kind* of database should you choose?

My aim is to give you enough information to make that choice, or at least be
aware of what the alternatives are.

I'd argue that there are five important database types at the moment, differing
in how they regard the "shape" of their data. I'll give a brief introduction to
each, explaining how it works, and discuss why you might want to use that
particular type of database, depending on your data and what you want to do
with it. I'll show case at least one open source example of each.

I'll cover:

* Relational (PostgreSQL®, SQLite)
* Columnar (ClickHouse®)
* Document (OpenSearch®)
* Key Value (Valkey™️)
* and as an extra, Graph (Neo4J®)

## Outline

> **Note** this is essentially what I promised to talk about.

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

## Links to the examplars

* https://www.postgresql.org/
* https://sqlite.org/ 
* https://github.com/ClickHouse/ClickHouse (Apache v2.0)
* https://clickhouse.com/
* https://opensearch.org/ and also https://lucene.apache.org/
* https://valkey.io/
* https://github.com/neo4j -> https://github.com/neo4j/neo4j (GPL3 license)
* https://neo4j.com/ and https://neo4j.com/product/neo4j-graph-database/


------

Three key references

* [A Relational Model of Data for Large Shared Data
  Banks](https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf) (PDF of the
  original paper by Codd from Communications of the ACM, volume 13, number 1
  6, June 1970)

I find the first part fascinating for its clarity and insight into what the
alternatives at the time were, and the second part, introducing joins and so
on, somewhat harder going (I'd need to draw diagrams)

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

------

SQLite has its own [quirks](https://SQLite.org/quirks.html), including less
rigorouse typing (indeed, you can create a column and not specify a type)

Given that, SQLite types are INTEGER, REAL, TEXT, BLOB, or NULL

------

### Embedded vector storage and querying

(does SQLite have? not as standard yet, but there are extensions - a quick
search yields [sqlite-vec](https://github.com/asg017/sqlite-vec). Also see
[How to Use sqlite-vec to Store and Query Vector
Embeddings](https://stephencollins.tech/posts/how-to-use-sqlite-vec-to-store-and-query-vector-embeddings))

(does valkey have yet? not as of 2025-06 - but see the PR [RFC for Valkey
Vector Search](https://github.com/valkey-io/valkey-rfc/pull/8) and related
issue [`[NEW]` Vector databse related
support](https://github.com/valkey-io/valkey/issues/950))


## Digression into planning - books and authors

> **Note** this is all prep work - the talk won't go into any of this, but
> will use the example I figure out.

I read a lot, and we have a lot of books at home (physical and ebooks), so
that's a natural direction for my mind to turn for examples. And a long time
ago I did a catalogue of the books we had at the time (using TeX!) so had to
play with the ideas first hand.

Also I once did a bibliography of an author, and learnt a lot from that
(collections with the same name but different contents, oh my).

And it's fairly common to use books and authors as an example for relational
databases:

* id, title, isbn, author, publisher

Let's consider fields we might want

* Title - this is a text string
  * But we might also want a "normalised" title - with any leading "The" taken
    out, maybe omitting some punctuation, and so on - this makes sorting and
    searching easier.
    
* Author name - this is a text string (fight me)
  * But names are hard (don't get me started on people who assume 'first name,
    last name' is a good way to look at them!), so we may also want
    * a "normalised" version of the name, in ASCII or otherwise romanised
    * a sortable version of the name (consider that we may want to sort on a
      surname if there is one, and you need to know provenance of the author
      to know whether `van XXX` is sorted on `van` or `XXX`)
  * And what if there's more than one author - so maybe this is an array
  * And what if it's a pseudonym, in which case it needs to refer to the
    actual author name, if known (or names)
  * So we probably want to store an author *id* (or an array of them) and link
    that, via the id, to an author table that contains an entry for each
    author, and a nullable pseudonym id column that can link to *another*
    author entry (do we want to allow recursion?), although again that should
    probably be an array of ids.
    
* ISBN - many books have ISBN numbers, they're fun and help disambiguate
  things. They're well defined, we should store them. Use a string.
  
* Publication date. This may just be a year (in which case an integer would
  suffice), but we might want a "proper" publication date (although beware
  books are sometimes purchasable before that date!)
  
* Publisher - another can of worms, of course, but let's assume just a name
  and use the standard id -> table with a name, and we can alway expand that
  table later on, when we (inevitably) discover we need to
  
* Oh, did I say add an id? We need a unique id because there's nothing else
  that can uniquely identify a book record (remember, titles aren't unique,
  and an ISBN is not compulsory). And relational databases need some way of
  making records unique, so an id (of whatever form the database prefers, but
  normally some form of ascending integer) is a good idea.

We're going to ignore illustrators. And editors of books with multiple items
inside, each with its own content and author, which might be published in more
than one place. And tags such as genre.

But you can see even this "simple" idea gets complicated and messy fairly quickly.


* so what do we do for a relational database to solve this?

  * https://stackoverflow.com/questions/19170855/relational-database-for-multiple-authors-multiple-books
    from 11 years ago
  * an interesting piece from NeXT Computer, 1995:
    https://www.nextcomputers.org/files/manuals/nd/Concepts/DatabaseKit/02_ERModeling.htmld/index.html,
    modelling books and borrowers
  * a nice piece from 2025
    https://www.linkedin.com/pulse/designing-relational-database-practical-example-using-mohammed-younis-87luf
  * the appendix from [A Practical Introduction to Databases](A Practical
    Introduction to Databases) which explains the example datasets used in the
    book
    https://runestone.academy/ns/books/published/practical_db/appendix-a-datasets/datasets.html
  * https://vertabelo.com/blog/database-for-library-system/ looks at the
    design of a simple library system, with borrowers and allowing for
    multiple copies of books


* columnar can clearly store the denormalised form of the relational data, but
  it's also going to be great for adding in all sorts of performance and cost
  data, and then analysing that. and provided the *aggregate* of the main
  columns gives us a unique answer, we don't need an `id` column, which is
  nice.
  
* document - classically we'd be storing some identifying information and then
  tokenised text from the book (&lt;smile&gt;) so we can perform textual
  analysis on it.
  
  or we're just using "JSON like" capabilities to store data and relying on
  indexing to be done for us. Again, this is likely to be useful for searching
  over things (but bear in mind PG offers similar syntactic and semantic
  search capabilities (the latter with embeddings))
  
  but of course if its opensearch we've also got the ability to visualise
  information about the corpus, in the service itself, which is great.
  
* is a key/value store actually useful here? we can store all the data we want
  as JSON in the value, but what is the key? and how much can we sort. on the
  other hand, it will be *excellent* as a way of caching results (query -> result)

* a graph database just lets us have nodes for each "thing" and then link them
  with appropriate references - great for storing the data, but reflects the
  real complexity of life with, well, real complexity.
  
  For instance, we might say a person can be the "author of" a piece, or the
  "editor of" a collection, and a "piece" might be "published as" a *form*
  (book, item in a book, poster), and so on and so forth. Each entity in the
  graph has a list of permitted relationships to other entities, and we can
  make it as complex as we like, or force simplicity if we wish.


### Codd and the invention of "relational"

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

### Basically, Codd showed that RDBs could do it all...

...and thats proven to be (essentially) the case
  
-----

### SQL

I don't think I'll have time to make more than a passing reference to
[SQL](https://en.wikipedia.org/wiki/SQL), especially not its history.

...I have vague memories of (what must have been)
[QUEL](https://en.wikipedia.org/wiki/QUEL_query_languages) from when we were
using INGRES in the late 1980s / early 1990s. I don't remember finding it
any "friendlier" than SQL (we were also using Oracle at the time).

### Open source examples: PostgreSQL, SQLite

Why two examples?

* PG - arguably the best relational database

* SQLite - interesting because it's a library and it's everywhere

https://en.wikipedia.org/wiki/Relational_database

https://www.postgresql.org/

...under its own license, https://www.postgresql.org/about/licence/. There's a
GitHub mirror of the source code, but that's not how it's developed - see
the https://wiki.postgresql.org/wiki/Developer_FAQ and
https://wiki.postgresql.org/wiki/Submitting_a_Patch

> SQLite is a C-language library that implements a small, fast,
> self-contained, high-reliability, full-featured, SQL database engine. SQLite
> is the most used database engine in the world.

SQLite is "public domain" - see https://SQLite.org/copyright.html - and while
it's open source, it isn't open-contribution. So that's interesting.

But also https://SQLite.org/ because it's a *library* that is packaged all
over the place (including in Python)

  [SQLite: The Database at the Edge of the Network with Dr. Richard Hipp
](https://www.youtube.com/watch?v=Jib2AmRb_rk) from 2015

https://SQLite.org/whentouse.html

> SQLite does not compete with client/server databases. SQLite competes with fopen().

So SQLite is in competition with writing to disk, and thus also with YAML, JSON, TOML.

> For device-local storage with low writer concurrency and less than a
> terabyte of content, SQLite is almost always a better solution. SQLite is
> fast and reliable and it requires no configuration or maintenance. It keeps
> things simple. SQLite "just works".

### More Links and notes

See the start for the classic "goes around" articles, and Codd's 1970 paper. 

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

## ClickHouse

* https://clickhouse.com/docs/faq/general/columnar-database
* [Columnar databases
  explained](https://clickhouse.com/engineering-resources/what-is-columnar-database) -
  I really like this article by ClickHouse, I think it's a very good
  explanation. It talks about the history, what columnar databases are,
  contrasts them with the row based approach, and has some good discussion on
  when to use each.

* Interesting: https://clickhouse.com/blog/a-new-powerful-json-data-type-for-clickhouse

Question to think about: are columnar databases relational?


### More notes and links

* Olena Kutsenko, 2023, [ClickHouse: what is behind the fastest columnar
  database](https://www.youtube.com/watch?v=mrJvoHJRs9Y) video from Berlin
  Buzzwords 2023, and [same talk](https://www.youtube.com/watch?v=96sLrRc4pC0)
  from Devoxx Ukraine 2023.
* (Start of) [ClickHouse Basic
  Tutorial](https://dev.to/hoptical/clickhouse-basic-tutorial-an-introduction-52il)
  on dev.to

## Document - *indexing*, **document processing**, **search**


### Discussion on MongoDB as a different sort of document database

> **Note** may be a brief mention in the talk. Obviously not open source, so
> technically my abstract has ruled it out anyway.

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
* 2024 Oracle on MongoDB [What Is MongoDB? An Expert Guide](https://www.oracle.com/uk/database/mongodb/)

and I'm sure there's other good stuff to consider.

Although, of course,
https://www.mongodb.com/resources/basics/databases/key-value-database also
argues that MongoDB is a key/value store - which is fair enough!

## Key Value - *caching* and more!

* https://en.wikipedia.org/wiki/Key%E2%80%93value_database

Valkey vector search / secondary indexing module: https://github.com/valkey-io/valkey-search

## Graph

https://en.wikipedia.org/wiki/Graph_database

What are alternatives to Neo4J?

https://en.wikipedia.org/wiki/Graph_database lists some examples, annotated by license.

https://github.com/kuzudb/kuzu / https://kuzudb.com/  wosounds interesting

---

Questions for the audience (and for discussion afterwards):

* Do they agree with that way of splitting up databases?
* Do they think I've missed something important?

## Appendix: But Postgres!

> **Note** This may or may not stay in the notes. It definitely won't have
> time to be in the talk. See also the abstract for the ["but just
> Postgres"](but-just-postgres-edition.md) version of this talk (which hasn't
> been written as an actual talk)

Of course, I'm a PostgreSQL fan, and in fact PG will let you do a lot of
things you don't expect. So this is the "but actually, you could just use
Postgres" appendix...

### Links for postgres as a relational database

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
