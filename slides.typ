// Get Polylux from the official package repository
#import "@preview/polylux:0.4.0": *

// Fletcher for diagrams
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: pill, chevron

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")

// Use big text for slides!
#set text(size: 25pt)

// And fonts. Typst seems to like Libertinus.
// (I do rather like the serif capital Q)
// I had to download it from the Releases folder at https://github.com/alerque/libertinus
// and install it using /Applications/Font Book
//
// Before that, I was being traditional and using "Times Roman" and "Helivitica"
// (or "Helvetica Neue")

#set text(font: "Libertinus Sans")

#show heading.where(
  level: 1
): it => text(
  font: "Libertinus Serif",
  it.body,
)

#show heading.where(
  level: 2
): it => text(
  font: "Libertinus Serif",
  it.body,
)

// Trying out QR codes
#import "@preview/tiaoma:0.3.0"

// I want URLs to be visibly such - otherwise they'll just be shown as normal text
// #show link: underline
#show link: set text(blue)

// Footer
#let slide-footer = context[
  #set text(size: 15pt, fill:gray)
  #toolbox.side-by-side[
    #align(left)[#toolbox.slide-number / #toolbox.last-slide-number]
  ][
    #align(right)[Mastodon: \@much_of_a, Bluesky: \@tibs]
  ]
]
#set page(footer: slide-footer)


// If a quote has an attribution, but is not marked as "block", then write
// the attribution after it (in smaller text)
// Adapted from an example in the Typst documentation for quote's attribution
// parameter, at https://typst.app/docs/reference/model/quote/
#show quote.where(block: false): it => {
  ["] + h(0pt, weak: true) + it.body + h(0pt, weak: true) + ["]
  if it.attribution != none [ -- #text(size:20pt)[#it.attribution]]
}

// Use #slide to create a slide and style it using your favourite Typst functions
#slide[
  #set align(horizon)

  // = Explaining the 5 types of database and how to choose between them

  #heading(
    level: 1,
    [Explaining the 5 types of database \
     and how to choose between them]
  )

  #v(20pt)

  Tibs (they / he)

  #grid(
    columns: 2,

    text(size: 20pt)[

      18#super[th] July 2025, EuroPython 2025

      Slides available at https://github.com/Aiven-Labs/the-5-types-of-database
    ],

    align(right,
      grid(
        rows: (auto, auto),
        align: center,
        row-gutter: 10.0pt,
        tiaoma.qrcode("https://aiven.io/tibs", options: (scale: 3.0)),
        text(size: 20pt)[https://aiven.io/tibs]
      )
    )
  )
]

#slide[

  == I think there are 5 database shapes

  - Relational
  - Columnar
  - Document
  - Key Value
  - Graph

  Let me tell you about them (with open source examples)
]

#slide[
  == Relational

  A table called *talks*

  #table(
    columns: 3, align: (right, left, left),
    fill: (x, y) => if y == 0 { luma(240) },
    [*id*], [*title*], [*speaker*],
    [1], [This talk by me], [Tibs],
    [2], [Another talk by me], [Tibs],
    [3], [John's talk], [John Smith],
  )
]

#slide[
  == Edgar F. Codd and relational theory

  - 1970 "A Relational Model of Data for Large Shared Data Banks"
    - Just simple enough
    - Just abstract enough
    - Represent just about anything

  - Contrasted with less flexible tree and network approaches
  - _Relation_ #sym.equiv  table
  - Took until the mid-1980s to "win"

]

// But note that Codd's rules are an abstract ideal, and real databases can
// diverge from them for practical reasons

// Modern RDBs can have quite sophisticated column types, including JSON/JSONB,
// arrays (and thus embedded vectors), binary blobs, _what else that's interesting?_

#slide[
  == Relational tables

  #grid(
    columns: 2,
    row-gutter: 2em,
    column-gutter: 10.0pt,
    [*talks*],
    table(
      columns: 3, align: (right, left, right),
      fill: (x, y) => if y == 0 { luma(240) },
      [*id*], [*title*], [*speaker_id*],
      [1], [This talk by me], text(red)[273],
      [2], [Another talk by me], text(red)[273],
      [3], [John's talk], text(blue)[301],
    ),
    [*attendees*],
    table(
      columns: 2, align: (right, left),
      fill: (x, y) => if y == 0 { luma(240) },
      [*id*], [*name*],
      text(red)[273], [Tibs],
      text(blue)[301], [John Smith],
      [308], [John Smith],
    ),
  )

]

#slide[
  == How to create those tables
  ```SQL
  CREATE TABLE attendees (
    id INT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
  );

  CREATE TABLE talks (
    id INT NOT NULL PRIMARY KEY,
    title TEXT NOT NULL,
    speaker_id INT REFERENCES attendees(id)
  );
  ```
]

#slide[
  == Finding my talks...
  ```sql
  SELECT talks.title FROM talks
    JOIN attendees ON attendees.id=talks.speaker_id
    WHERE attendees.name="Tibs";
  ```
  gives the results
  ```text
  This talk by me
  Another talk by me
  ```
]

#slide[
  == Characteristics of relational databases

  - Tables and rows and columns
  - Schema design up front
  - Transactions (pretty much always)
  // - ACID (_explain *very* briefly_)
  // - OLTP (online transaction processing)
]

// #slide[
//   #image("diagrams/rdb-tables.svg", height: 120%)
// ]

#slide[
  == Queries

  *SQL*

  - Originates in the 1970s
  - Originally called "SEQUEL" (Structured English Query Language)
  - Standardised in the 1980s
  - Latest version 2023
]

// SEQUEL may have been a pun (or a dig) at Ingres's QUEL query language

#slide[
  == Relational example 1: PostgreSQL®

  #image("images/elephant.png", height:50pt)

  #quote[
    PostgreSQL is a powerful, open source object-relational database
    system with over 35 years of active development that has earned it a
    strong reputation for reliability, feature robustness, and performance.
  ]
]

// 35 years => 2025 - 35 -> 1990

#slide[
  == More on PostgreSQL

  - Rich datatypes
  - Stored functions
  - Extensibility
  - Excellent documentation
  - Pretty much always a good place to start
]

#slide[
  == Relational example 2: SQLite

  #image("images/SQLite370_banner.svg", height:50pt)

  #quote[
    SQLite is a C-language library that implements a small, fast,
    self-contained, high-reliability, full-featured, SQL database engine. SQLite
    is the most used database engine in the world.
  ]
]

#slide[
  == More on SQLite

  - A library
  - Built into the Python standard library
    - It's everywhere
  - Single user
  - Slightly odd in some ways (schema is optional)
  - Use it instead of #smallcaps(all: true)[JSON]/#smallcaps(all: true)[YAML]/#smallcaps(all: true)[TOML] for storing data locally!
]

// Defend that "slightly odd" - datatypes being limited, what else...
// See [SQLite quirks](https://SQLite.org/quirks.html), including less
// rigorouse typing (indeed, you can create a column and not specify a type)
//
// Note: SQLite types are INTEGER, REAL, TEXT, BLOB, or NULL

#slide[
  == When to use a relational database

  - Almost always a good place to start
  - If your data fits
    - It probably does...
  - Whatever you need to do, some RDB can probably do it, and likely fast enough

  ... but please still stay for the rest of this talk!
]


#slide[
  == Columnar

  `<picture of table with columns slightly separated>`
]

#slide[
  == Characteristics of columnar databases

  - Essentially an optimisation of the relational idea
  - Store data as columns, not rows
  - We know the column datatype, so we can *compress* column data
    - Giving more efficient data storage
    - Especially effective for data that doesn't change a lot

  Aimed at large amounts of data with potentially large numbers of columns
]

#slide[
  == What's fast, what's slow
  - Adding new rows is fast
  - Adding new columns is fast
  - Querying a few columns out of many is fast

  - Changing or deleting rows is slow
]

#slide[
  == What data does that suit?

  - Log data
  - Sensor data
  - Time series data in general

  - Data stored for historical purposes
]

#slide[
  == OLAP: Online Analytical Processing.

  #quote(
    block: true,
    attribution: [
      #link("https://clickhouse.com/docs/concepts/olap")[clickhouse.com/docs/concepts/olap]
    ],
    [
      At the highest level, you can just read these words backward:
      - *Processing*: some source data is processed ...
      - *Analytical*: to produce some analytical reports and insights ...
      - *Online*: in real-time.
    ]
  )

  In contrast to OLTP (Online Transaction Processing)
]

#slide[
  == Compressing columns

  `<picture of table with columns slightly separated, showing how they're compressed>`
]

#slide[
  == Columnar example: ClickHouse®

  #image("images/ClickHouse_Logo_Black_FNL.svg", height:50pt)

  #quote(
    attribution: [
      #link("https://github.com/ClickHouse/ClickHouse")[github.com/ClickHouse/ClickHouse]
    ],
    [
      ClickHouse® is an open-source column-oriented database management
      system that allows generating analytical data reports in real-time.
    ]
  )

  #quote(
    attribution: [
      #link("https://clickhouse.com")[clickhouse.com]
    ],
    [
      ClickHouse is the fastest and most resource efficient real-time
      data warehouse and open-source database.
    ]
  )

]

#slide[
  == Queries

  *SQL*

  _It's still SQL 🙂_
]

#slide[
  == More about ClickHouse

  - Records don't have to have a unique primary key
    - Although having one can help
  - "Full fledged" transactions aren't supported
    - But this is less important if the main operation is adding new records and querying
]

#slide[
  == When to use a columnar database

  _Need to work on this!_

  - When you have lots of columns and want to query relatively few
  - When you have a lot of data
    - Which you don't want to alter
]

#slide[
  == Document

  `<picture of a JSON document>`
]

#slide[
  == Document database concepts

  - _Documents_ are essentially JSON
  - An _index_ is a collection of documents
  - When you search (for a word) you get back all documents that matched, with a
    _relevance score_ for how well they matched
  - To scale, indexes are split into _shards_, each with a subset of the documents.
]

#slide[
  == Characteristics of document databases

  - Relatively unstructured data
  - But want indexing
  - And rich querying
]

#slide[
  == Document example: OpenSearch®

  #image("images/opensearch_logo_default.svg", height:50pt)

  #quote[
    OpenSearch is an open-source, enterprise-grade search and observability
    suite that brings order to unstructured data at scale
  ]
]

#slide[
  == Queries

  HTTP requests JSON structures
]

#slide[
  == More about OpenSearch

  - Technology origins in document processing, indexing and searching over large bodies of text
  - Designed to be distributed - scaling *horizontally*
  - Backed by #link("https://lucene.apache.org/")[Apache Lucene]
  - Queries are written in JSON
  - Schema design up front is optional - it will deduce a schema for you
  - Data visualisation tools built in
]

// The Lucene project was started in 1999!
//
// "Lucene Core is a Java library providing powerful indexing and search
// features, as well as spellchecking, hit highlighting and advanced
// analysis/tokenization capabilities. The PyLucene sub project provides
// Python bindings for Lucene Core."
//
// OpenSearch deducing the schema for you can have all the problems you
// should expect that to give!
//

#slide[
  == A dashboard about mastodon messages

  #image("images/blog-kafka-mastodon-2-past-15-minutes.png", height: 80%)
]

#slide[
  == When to use a document database

  - Fast, scalable full text search
  - Storage of indexable JSON documents
  - In the case of OpenSearch, sophisticated analytics visualisation
]

#slide[
  == Key Value


  //#show figure.where(
  //  kind: table
  //): set figure.caption(position: top)

  #show figure.caption: it => [
    \
    #it.body
  ]


  #figure(
    diagram(
      node-fill: teal.lighten(50%),
      spacing: 1em,

      node( (0,0), [key1], shape: chevron, outset: 5pt ),
      edge("=>"),
      node( (2,0), [value1], shape: pill, outset: 5pt ),
      node( (0,1), [key2], shape: chevron, outset: 5pt ),
      edge("=>"),
      node( (2,1), [value2], shape: pill, outset: 5pt ),
      node( (0,2), [key3], shape: chevron, outset: 5pt ),
      edge("=>"),
      node( (2,2), [value3], shape: pill, outset: 5pt ),
    ),
    caption: [A picture of a dictionary 🙂]
  )
]

#slide[
  == Characteristics of key value databases

]

#slide[
  == Key Value example: Valkey™

  #image("images/valkey-horizontal.svg", height:50pt)

  #quote[
    Valkey is an open source (BSD) high-performance key/value datastore that
    supports a variety of workloads such as caching, message queues, and can
    act as a primary database.
  ]
]

#slide[
  == Queries

  Its own protocol, with its own CLI

  It's actually rather lovely...

  The operation used determines how the value is interpreted

  ```
  SET this_key "Hello" EX 60
  HSET this_hash field1 "Hello"
  LSET this_list 0 "zero"
  JSON.SET this_json . '{"a":{"a":1, "b":2, "c":3}}'
  ```
]

#slide[
  == More about ValKey

  - In-memory, but persistent to disk
  - Think like a Python dictionary!
  - "Obvious" use is for caching, with the value expiry support
  - but also pub/sub support (SUBSCRIBE, UNSUBSCRIBE, PUBLISH)
  - and message queues (Streams provide an append-only log)
  - and because of its sophisticated value datatypes (geospatial indexing!)
]

#slide[
  == When to use a key value database

  - When your data fits the "key" -> "value" idea
  - Caching (for instance, URL -> page results)
  - Valkey:
    - when you want your data to expire
    - pub/sub messaging
    - message queues
    - for its datatypes
]

// Remember, nice programmers don't let other programmers do messaging using an RDB,
// but ValKey is a sensible option

#slide[
  == Graph

  #diagram(

  node-fill: teal.lighten(50%),
  spacing: 1em,

  node( (0,0), [node1], name: <n1>, shape: circle, outset: 1pt ),
  node( (3,2), [node2], name: <n2>, shape: circle, outset: 1pt ),
  node( (1,4), [node3], name: <n3>, shape: circle, outset: 1pt ),
  node( (5,4), [node4], name: <n4>, shape: circle, outset: 1pt ),
    edge(<n1>, "->", <n2>, label: [relA], label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<n2>, "->", <n3>, label: [relB], label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<n3>, "->", <n4>, label: [relC], label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<n4>, "->", <n2>, label: [relD], label-size: 0.8em, label-sep: 0pt, label-angle: auto),
  )

 *not* an XY data graph 🙂
]

// I mean, this slide is way too long
#slide[
  == Characteristics of graph databases

 _Nodes_, _relationships_ and _properties_

  - or _objects_, _references_ and _attributes_
  - or _nodes_, _edges_ and _values_
  - or ...
]

#slide[
  == Nodes

  Nodes have
  - a type
  - properties
  - are linked by relationships
]

#slide[
  == Relationships

  Relationships
  - are between nodes
  - are 1:1 or 1:many
  - *may* be single or bidirectional (I have opinions)
  - *may* have properties (I have opinions)
]

#slide[
  == Graph database schemas

  - Objects have a type which says what relationships and attributes they can have
  - Relationships have a type (name?) which says what object types they can relate, and what attributes they can have
]

// Gothic and my own experience, but briefly

#slide[
  == Graph example: Neo4J®

  #image("images/neo4j-logo.svg", height:50pt)

  #quote(
    attribution: [
      #link("https://neo4j.com")[neo4j.com]
    ],
    [
      the world's most-loved graph database
    ]
  )

  #quote(
    attribution: [
      #link("https://github.com/neo4j/neo4j")[github.com/neo4j/neo4j]
    ],
    [
      Neo4j is the world’s leading Graph Database. It is a high performance
      graph store with all the features expected of a mature and robust
      database, like a friendly query language and ACID transactions.    ]
  )
]

#slide[
  == More about Neo4J

  Another quote

  #quote[
    The programmer works with a flexible network structure of nodes and
    relationships rather than static tables — yet enjoys all the benefits of
    enterprise-quality database.
  ]
]

#slide[
  == More about Neo4J nodes

  - Nodes
    - are tagged with _labels_ (to indicate their role)
    - have any number of key:value properties
    - be indexed
    - have constraints on their content
]

#slide[
  == More about Neo4J relationships

  - Relationships
    - have a name
    - must have a type, a start node and an end node
    - must have a direction
    - can have properties
]

#slide[
  == Queries: Neo4J has Cypher

  ```
  CREATE (p:Person
    {name:'Sally'})-[r:IS_FRIENDS_WITH]->
      (p:Person {name:'John'}
  )
  ```
  ```
  MATCH p=shortestPath(
    (bacon:Person {name:"Kevin Bacon"})-[*]-
      (meg:Person {name:"Meg Ryan"})
  ) RETURN p
  ```
]

#slide[
  == When to use a graph database

  - When you have a knowledge graph shaped puzzle
  - When you want that flexibility to build structures as you learn them (note: Neo4J specific)
  - Although you _can_ represent graph data in relational systems, you're missing out on
    the community of graph-based solutions that come with a mature graph database
]

#slide[
  == Things just about all the shapes give you

  - ACID compliance [citation needed]
  - Transactions
  - Extensibility
  - Vector search (ValKey not yet, SQLite there's an extension)
  - JSON support (ValKey sort of, SQLite not so much)
]

// Extra slide - probably won't need / have time for
#slide[
  == ACID and transactions

  - *Atomic* \
    each transaction is a "unit" that succeeds or fails completely
  - *Consistent* \
    each transaction takes the db from one consistent state to another
  - *Isolated* \
    concurrent transactions result as if they had been sequential
  - *Durable* \
    once a transaction is committed, it stays committed\
    (even if the database falls over)
]

// Extra slide - probably won't need / have time for
#slide[
  == CAP theorem

  - *Consistent* \
    every read gets the most recent write, or an error
  - *Available* \
    every request to a working node produces a response
  - *Partition tolerant* \
    the system keeps working when the network between nodes is flaky

  (choose any 2)
]

// https://en.wikipedia.org/wiki/ACID
// https://en.wikipedia.org/wiki/CAP_theorem

#slide[
  == What we've looked at

  Five different kinds (shapes) of database

  #table(
    columns: 3,
    align: left,
    fill: (y, _) =>
      if calc.odd(y) { luma(240) }
      else { white },
    //column-gutter: 2em,
    //row-gutter: 20pt,
    [Relational], [PostgreSQL®], [#text(size: 20pt)[Use for just about anything]],
    [ ], [SQLite], [#text(size: 20pt)[Use in your programs, use locally]],
    [Columnar], [ClickHouse®], [#text(size: 20pt)[Use for OLAP, column oriented data]],
    [Document], [OpenSearch®], [#text(size: 20pt)[Use for text corpuses, semi-structured data, indexing]],
    [Key Value], [Valkey™️],  [#text(size: 20pt)[Use for caching, pub/sub, simple queues]],
    [Graph], [Neo4J®], [#text(size: 20pt)[Use for graph/network data]],
  )
]

#slide[
  == Acknowledgements

  #text(
    size: 20pt,
    [
      Postgres, PostgreSQL and the Slonik Logo are trademarks or registered
      trademarks of the PostgreSQL Community Association of Canada, and used with
      their permission.

      ClickHouse is a registered trademark of ClickHouse, Inc. https://clickhouse.com.

      The OpenSearch Project is a project of The Linux Foundation.

      Valkey and the Valkey logo are trademarks of LF Projects, LLC.

      Neo4j®, Neo Technology®, Cypher®, Neo4j® Bloom™, Neo4j® AuraDS™ and Neo4j®
      AuraDB™ are registered trademarks of Neo4j, Inc. All other marks are owned by
      their respective companies.
    ]
  )

]

#slide[
  == Aiven

  I work for Aiven _Your AI-ready Open Source Data Platform_, and we provide
  managed versions of PostgreSQL, ClickHouse, ValKey and OpenSearch (and free
  versions of PG and ValKey).
]


// Remember to update the shortlink go.aiven.io/tibs-signup
// Also check we're still hiring before giving the talk
#slide[
  == Fin

  #grid(
    rows: 2,
    columns: (auto, auto),
    align: left,
    row-gutter: 2em,
    column-gutter: 10.0pt,

    [
      Get a free trial of Aiven services at \
      http://go.aiven.io/tibs-signup

      Also, we're hiring! See https://aiven.io/careers
    ],
    tiaoma.qrcode("https://go.aiven.io/tibs-signup", options: (scale: 2.35)),

    [
      Slides created using
      #link("https://typst.app/")[typst] and
      #link("https://typst.app/universe/package/polylux/")[polylux],
      and available at
      https://github.com/Aiven-Labs/the-5-types-of-database, licensed
      #box(
        baseline: 50%,
        image("images/cc-attribution-sharealike-88x31.png"),
      )
    ],

    tiaoma.qrcode("https://github.com/Aiven-Labs/the-5-types-of-database", options: (scale: 2.0)),
  )

]
