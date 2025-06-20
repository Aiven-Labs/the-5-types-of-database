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

  _A brief introduction_

  ...mention normalisation and why it's interesting...

  ...the point being that we actually *know* that we can represent anything
  in an RDB (although not with a guarantee of efficiency)...
]

// But note that Codd's rules are an abstract ideal, and real databases can
// diverge from them for practical reasons

#slide[
  == Characteristics of relational databases

  - Tables and rows
  - Schema design up front
  - Transactions (pretty much always)
  - ACID (_explain *very* briefly_)
  - ...
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

#slide[
  == More on PostgreSQL

  - ...
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
  - Single user
  - Use it instead of #smallcaps(all: true)[JSON]/#smallcaps(all: true)[YAML]/#smallcaps(all: true)[TOML] for storing data locally!
]

#slide[
  == When to use a relational database

  - Almost always a good place to start
  - If you want ACID compliance as a given (caveat - do check!)
  - If your data fits
]


#slide[
  == Columnar

  `<picture of table with columns slightly separated>`
]

#slide[
  == Characteristics of columnar databases

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

  _Is it an SQL variant for ClickHouse?_
]

#slide[
  == More about ClickHouse
]

#slide[
  == When to use a columnar database

  _Need to work on this!_

  - When you have lots of columns but queries return only a few
  - When you have a lot of data
  - When denormalised data is an advantate
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

  - Objects and relations (or nodes and edge, or ...)
    - _what does Neo4J call them?_
  - Objects can have attributes
  - Relations can have attributes (well, ask me afterwards about my opinion!)
  - Relations are (should be) bidirectional
]

#slide[
  == Graph database schemas
  - Objects have a type which says what relationships and attributes they can have
  - Relations have a type (name?) which says what object types they can relate, and what attributes they can have
  - Relations are 1:1 or 1:many (and thus many:1 because bidirectional!)
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
  == Queries

  ???
]

#slide[
  == When to use a graph database
]

#slide[
  == What we've looked at

  Five different kinds (shapes) of database

  - Relational: PostgreSQL®
  - Relational: SQLite

  - Columnar: ClickHouse®

  - Document: OpenSearch®

  - Key Value: Valkey™️

  - Graph: Neo4J®

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
