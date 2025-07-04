// Get Polylux from the official package repository
#import "@preview/polylux:0.4.0": *

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

  `<picture of table>`
]

#slide[
  == Codd and relational theory

  - 1970 paper "A Relational Model of Data for Large Shared Data Banks"
  - _Relation_ is his mathematical term for what we now call a table
  - Contrasted with less flexible tree and network approaches
  - Just simple enough; just abstract enough; represent just about anything
  - Took until the mid-1980s to "win"

]

//

// But note that Codd's rules are an abstract ideal, and real databases can
// diverge from them for practical reasons

#slide[
  == Characteristics of relational databases

  - Tables and rows
  - Schema design up front
  - Normalisation and joins
  - Transactions (pretty much always)
  - ACID (_explain *very* briefly_)
  - OLTP (online transaction processing)
]

// Modern RDBs can have quite sophisticated column types, including JSON/JSONB,
// arrays (and thus embedded vectors), binary blobs, _what else that's interesting?_

#slide[
  == Relational: joins

  `<picture of 2 tables, joined>`
]

#slide[
  == Queries

  *SQL*

  Standardised in ...
]

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
  - If you want ACID compliance as a given (caveat - do check!)
  - If your data fits
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
  - Prioritises _columns_ over _rows_
  - Aimed at large amounts of data with potentially large numbers of columns
    - Not designed for normalised data
    - Not really designed for handling joins
  - Column operations fast (especially querying)
  - Deleting or updating rows not so fast
  - OLAP (online analytical processing)

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

  _How close to standard is ClickHouse SQL?_
]

#slide[
  == More about ClickHouse
]

#slide[
  == When to use a columnar database

  _Need to work on this!_

  - When you have lots of columns and want to query relatively few
  - When you have a lot of data
  - When denormalised data is an advantage
  - When you are generally adding new data, not changing it
]

#slide[
  == Document

  `<picture of a JSON document>`
]

#slide[
  == Characteristics of document databases

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

#slide[
  == When to use a document database
]

#slide[
  == Key Value

  `<picture of a dictionary 🙂 >`
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
]

#slide[
  == More about ValKey

  - Think like a Python dictionary!
  - "Obvious" use is for caching
    - but there's much more than that, including some nice pub/sub messaging support
]

#slide[
  == When to use a key value database
]

// Remember, nice programmers don't let other programmers do messaging using an RDB,
// but ValKey is a sensible option

#slide[
  == Graph

  `<picture of object graph>`, *not* `picture of XY data graph`
]

// I mean, this slide is way too long
#slide[
  == Characteristics of graph databases

  - _Nodes_ and _relations_
    - (or _objects_ and _relations_, or _nodes_ and _edges_, or ...)
  - Both can have attributes (I have opinions)
  - Relations are (should be) bidirectional
  - Relations are 1:1 or 1:many (and thus many:1 because bidirectional)
]

#slide[
  == Graph database schemas

  - Objects have a type which says what relationships and attributes they can have
  - Relations have a type (name?) which says what object types they can relate, and what attributes they can have
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

  - Schema (node and relation types) are implicit.

    _Can they be defined up front? Check what current practices are._
]

#slide[
  == Queries

  ???
]

#slide[
  == When to use a graph database
]

#slide[
  == Things just about all the shapes give you

  - ACID compliance [citation needed]
  - Transactions
  - Extensibility
  - Vector search
  - JSON support
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
