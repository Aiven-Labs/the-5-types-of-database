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

// Give a very light grey background to code blocks
#show raw.where(block: true): it => block(
  fill: luma(240),
  inset: 5pt,
  it
)

// But be more subtle with inline code
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
)


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
]

#slide[
  == 1. Relational

  A table called *books*

  #show table.cell.where(y: 0): strong
  #table(
    columns: 3, align: (right, left, left),
    fill: (x, y) => if y == 0 { luma(240) },
    table.header([id], [title], [author]),
    [1], [This Book], [Tibs],
    [2], [That Book], [Tibs],
    [3], [John's Book], [John Smith],
  )
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Relational]
])

#slide[
  == Edgar F. Codd and relational theory

  #let codd-image = context[
    #show figure.caption: it => [
      #it.body
    ]
    #figure(
      image("images/Edgar_F_Codd.jpg"), //, height:50pt)
      caption: text(size: 10pt, fill:gray)[
        Picture of Edgar "Ted" Codd from #link("https://en.wikipedia.org/wiki/Edgar_F._Codd/")[wikipedia]
      ]
    )
  ]

  #grid(
    columns: 2,
    codd-image,
    [
      1970 "A Relational Model of Data for Large Shared Data Banks"
      - Just simple enough
      - Just abstract enough
      - Represent just about anything
    ]
  )

  //- Contrasted with less flexible tree and network approaches
  - _Relation_ #sym.equiv  table
  - Took until the mid-1980s to "win"

]

// Codd as the grandaddy of relational databases

// But note that Codd's rules are an abstract ideal, and real databases can
// diverge from them for practical reasons

// Modern RDBs can have quite sophisticated column types, including JSON/JSONB,
// arrays (and thus embedded vectors), binary blobs, _what else that's interesting?_

#slide[
  == Relational tables

  #show table.cell.where(y: 0): strong
  #grid(
    columns: 2,
    row-gutter: 2em,
    column-gutter: 10.0pt,
    [*books*],
    table(
      columns: 3, align: (right, left, right),
      fill: (x, y) => if y == 0 { luma(240) },
      table.header([id], [title], [author_id]),
      [1], [This Book], text(red)[273],
      [2], [That Book], text(red)[273],
      [3], [John's Book], text(blue)[301],
    ),
    [*authors*],
    table(
      columns: 2, align: (right, left),
      fill: (x, y) => if y == 0 { luma(240) },
      table.header([id], [name]),
      text(red)[273], [Tibs],
      text(blue)[301], [John Smith],
      [308], [John Smith],
    ),
  )

]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == Concept: SQL

  #quote(
    attribution: [
      #link("https://en.wikipedia.org/wiki/SQL")[en.wikipedia.org/wiki/SQL]
    ],
    [
      a domain-specific language used to manage data, especially in a
      relational database management system
    ]
  )

  - Originates in the 1970s
  - Originally called "SEQUEL" (Structured English Query Language)
  - Standardised in the 1980s
  - Latest version 2023
]

// SEQUEL may have been a pun (or a dig) at Ingres's QUEL query language

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Relational]
])

#slide[
  == How to create those tables
  ```SQL
  CREATE TABLE authors (
    id INT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
  );

  CREATE TABLE books (
    id INT NOT NULL PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INT REFERENCES authors(id)
  );
  ```
]

#slide[
  == Finding my books...
  ```sql
  SELECT books.title FROM books
    JOIN authors ON authors.id=books.author_id
    WHERE authors.name="Tibs";
  ```
  gives the results
  ```text
  This book
  That book
  ```
]

/*
#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == Concept: Transactions

  - If data is split between multiple tables
    - then we'll need to change multiple tables "at the same time"
  - Transactions let us do this

  #v(20pt)

  1. `START` a transaction
  2. Do all the edits
  3. Either `COMMIT` or `ROLLBACK`
]

#slide[
  == Transaction example

  ```sql
  START TRANSACTION;
  UPDATE authors SET name = "Eric Smith" WHERE id = 301;
  UPDATE books SET name = "Eric's book" WHERE id = 3;
  COMMIT;
  ```

  // Can't use table.header for the tables because it can only be used
  // for the first row, and I have two header rows...
  #grid(
    columns: 3,
    row-gutter: 2em,
    column-gutter: 10.0pt,
    [gives],
    table(
      columns: 3, align: (right, left, right),
      fill: (x, y) => if y in (0, 1) { luma(240) },
      table.cell(align: left, colspan: 3, [*books*]),
      [*id*], [*title*], [*author_id*],
      [1], [This Book], text(red)[273],
      [2], [That Book], text(red)[273],
      [3], text(olive)[Eric's Book], text(blue)[301],
    ),
    table(
      columns: 2, align: (right, left),
      fill: (x, y) => if y in (0, 1) { luma(240) },
      table.cell(align: left, colspan: 2, [*authors*]),
      [*id*], [*name*],
      text(red)[273], [Tibs],
      text(blue)[301], text(olive)[Eric Smith],
      [308], [John Smith],
    ),
  )
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Relational]
])
*/

#slide[
  == Characteristics of relational databases

  - Tables and rows and columns

  - Schema design up front

  /*
  - Transactions #text(fill: gray)[(pretty much always)]
    - OLTP (online transaction processing)
  */
]

#slide[
  == Relational example 1: PostgreSQL®

  #image("images/elephant.png", height:50pt)

  #quote(
    attribution: [
      #link("https://www.postgresql.org/about/")[www.postgresql.org/about]
    ],
    [
    PostgreSQL is a powerful, open source object-relational database
    system with over 35 years of active development that has earned it a
    strong reputation for reliability, feature robustness, and performance.
    ]
  )
]

// 35 years => 2025 - 35 -> 1990

// Pronunciation Post-Gres-Q-L (the link has an audio file!)
// https://wiki.postgresql.org/wiki/FAQ#What_is_PostgreSQL.3F_How_is_it_pronounced.3F_What_is_Postgres.3F

#slide[
  == More on PostgreSQL

  - Rich datatypes

  - Stored functions

  - Extensibility

  - Excellent documentation

  - Always a good place to start
]

#slide[
  == Relational example 2: SQLite

  #image("images/SQLite370_banner.svg", height:50pt)


  #quote(
    attribution: [
      #link("https://www.sqlite.org/")[www.sqlite.org]
    ],
    [
    SQLite is a C-language library that implements a small, fast,
    self-contained, high-reliability, full-featured, SQL database engine. SQLite
    is the most used database engine in the world.
    ]
  )

  #quote(
    attribution: [
      #link("https://www.sqlite.org/")[www.sqlite.org]
    ],
    [Small. Fast. Reliable. Choose any three.]
  )
]

// Pronunciation: Its creator says "Ess-Cue-El-ite" but also says he doesn't
// care how other people pronounce it

#slide[
  == More on SQLite

  - A library

  - Built into the Python standard library
    - It's everywhere

  - Single user

  - Slightly odd in some ways (schema is optional)

  - Use it instead of #smallcaps(all: true)[JSON]/#smallcaps(all: true)[YAML]/#smallcaps(all: true)[TOML] for local storage!
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

  - Whatever you need to do, some RDB can probably do it
    - and likely fast enough

  #v(20pt)

  ... but please still stay for the rest of this talk!
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == 2. Columnar

  *book sales*

  #table(
    columns: 6,
    align: (left, right, left, right, right, right),
    fill: (x, y) => if y == 0 { luma(240) },
    column-gutter: 20pt,
    [*dt*], [*id*], [*title*], [*price*], [*quantity*], [*customer_id*],
    text(size:20pt)[20250101 12:01], [1], [This Book], [5.20], [1], [1005],
    text(size:20pt)[20250101 12:14], [1], [This Book], [4.50], [2], [923],
    text(size:20pt)[20250101 19:27], [1], [This Book], [5.20], [1], [85],
    text(size:20pt)[20250101 20:14], [3], [Eric's Book], [4.00], [1], [1002],
    text(size:20pt)[20250101 20:14], [2], [That Book], [5.20], [1], [1002],
  )
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Columnar]
])

#slide[
  == Characteristics of columnar databases

  - Essentially an optimisation of the relational idea

  - Store data as columns, not rows

  - We know the column datatype, so we can *compress* column data
    - Giving more efficient data storage
    - Good for data that doesn't change a lot
]

/*
// This first view of compressed columns is nice, but if I'm going to have only one
// then I think the second is more useful

#slide[
  == Compressing columns - unused version

  *book sales*

  #show table.cell.where(y: 0): strong
  #table(
    columns: 6,
    align: (left, right, left, right, right, right),
    fill: (x, y) => if y == 0 { luma(240) },
    column-gutter: 20pt,
    table.header(
      [dt], [id], [title], [price], [quantity], [customer_id],
    ),
    // row 1
    text(size:20pt)[20250101 12:01],
    table.cell(rowspan: 3, fill:yellow, [1]),
    table.cell(rowspan: 3, fill:yellow, [This Book]),
    [5.20],
    [1],
    [1005],
    // row 2
    text(size:20pt)[20250101 12:14],
    // id spanned
    // title spanned
    [4.50],
    [2],
    [923],
    // row 3
    text(size:20pt)[20250101 19:27],
    // id spanned
    // title spanned
    [5.20],
    table.cell(rowspan: 3, fill:yellow, [1]),
    [85],
    // row 4
    table.cell(rowspan: 2, fill: yellow, text(size:20pt)[20250101 20:14]),
    [3],
    [Eric's Book],
    [4.00],
    // quantity spanned
    table.cell(rowspan: 2, fill:yellow, [1002]),
    // row 5
    // dt spanned
    [2],
    [That Book],
    [5.20],
    // quantity spanned
    // customer_id spanned
  )
]
*/

#slide[
  == Compressed columns

  *book sales*

  #show table.cell.where(y: 0): strong
  #table(
    columns: 6,
    align: (left, right, left, right, right, right),
    fill: (x, y) => if y == 0 { luma(240) },
    column-gutter: 20pt,
    table.header(
      [dt], [id], [title], [price], [quantity], [customer_id],
    ),
    // row 1
    text(size:20pt)[20250101 12:01],
    table.cell(fill:yellow, [1]),
    table.cell(fill:yellow, [This Book]),
    [5.20],
    [1],
    [1005],
    // row 2
    text(size:20pt)[20250101 12:14],
    table.cell(stroke: none)[  ], // id spanned
    table.cell(stroke: none)[  ], // title spanned
    [4.50],
    [2],
    [923],
    // row 3
    text(size:20pt)[20250101 19:27],
    table.cell(stroke: none)[  ], // id spanned
    table.cell(stroke: none)[  ], // title spanned
    [5.20],
    table.cell(fill:yellow, [1]),
    [85],
    // row 4
    table.cell(fill: yellow, text(size:20pt)[20250101 20:14]),
    [3],
    [Eric's Book],
    [4.00],
    table.cell(stroke: none)[  ], // quantity spanned
    table.cell(fill:yellow, [1002]),
    // row 5
    table.cell(stroke: none)[  ], // dt spanned
    [2],
    [That Book],
    [5.20],
    table.cell(stroke: none)[  ], // quantity spanned
    table.cell(stroke: none)[  ], // customer_id spanned
  )
]
/* I think this view is confusing (although it was fun to make) so don't intend to use it
#slide[
  == Compressing columns - compressed view

  *book sales*

  #show table.cell.where(y: 0): strong
  #table(
    columns: 6,
    align: (left, right, left, right, right, right),
    fill: (x, y) => if y == 0 { luma(240) },
    column-gutter: 20pt,
    table.header(
      [dt], [id], [title], [price], [quantity], [customer_id],
    ),
    // row 1
    text(size:20pt)[20250101 12:01],
    table.cell(fill:yellow, [1]),
    table.cell(fill:yellow, [This Book]),
    [5.20],
    [1],
    [1005],
    // row 2
    text(size:20pt)[20250101 12:14],
    [3],
    [Eric's Book],
    [4.50],
    [2],
    [923],
    // row 3
    text(size:20pt)[20250101 19:27],
    [2],
    [That Book],
    [5.20],
    table.cell(fill:yellow, [1]),
    [85],
    // row 4
    table.cell(fill: yellow, text(size:20pt)[20250101 20:14]),
    table.cell(stroke: none)[  ], // id spanned
    table.cell(stroke: none)[  ], // title spanned
    [4.00],
    table.cell(stroke: none)[  ], // quantity spanned
    table.cell(fill:yellow, [1002]),
    // row 5
    table.cell(stroke: none)[  ], // dt spanned
    table.cell(stroke: none)[  ], // id spanned
    table.cell(stroke: none)[  ], // title spanned
    [5.20],
    table.cell(stroke: none)[  ], // quantity spanned
    table.cell(stroke: none)[  ], // customer_id spanned
  )

  Columns no longer "match up" - the compressed items need extra information to specify their span
]
*/

#slide[
  == What's fast, what's slow

  Fast:

  - Adding new rows
  - Adding new columns
  - Querying a few columns out of many

  Slow:

  - Changing or deleting rows
]

#slide[
  == What data does that suit?

  - Log data
  - Sensor data
  - Time series data in general

  - Data stored for historical purposes
]

/*
#slide[
  == Concept: OLAP -- Online Analytical Processing.

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
*/

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
  == More about ClickHouse

  - Queries are still SQL 🙂
    - With some extras and useful utility functions

  - Records don't have to have a unique primary key
    - Although having one can help

  /*
  - "Full fledged" transactions aren't supported
    - Do we really need them for OLTP?
  */
]

// https://clickhouse.com/docs/guides/developer/transactional
// Describes the limitations, and then explains some _experimental_ transaction support
// (it's not available in ClickHouse Cloud, nor does Aiven enable it)

#slide[
  == Create book sales table

  #toolbox.side-by-side[
  ```sql
  CREATE TABLE book_sales (
    dt DateTime,
    id BIGINT,
    title String,
    price Decimal(8,2),
    quantity Int,
    customer_id BIGINT,
  ) ENGINE = MergeTree()
  PARTITION BY toYYMM(dt)
  ORDER BY (title, dt)
  ```
  ][
  Find the 10 top sellers
  ```sql
  SELECT
    id, title, sum(quantity) AS
       total_quantity
  FROM book_sales
  GROUP BY id
  ORDER BY total_quantity DESC LIMIT 10
  ```
  ]
]

#slide[
  == When to use a columnar database

  - When you want to query on columns not rows

  - When you have lots of columns

  - When you have a lot of data
    - Which you don't want to alter
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == 3. Document

  ```json
  {
    "title": "This Book",
    "author": "Tibs",
    "isbn": null,
    "publisher": "self-published",
    "tags": ["nonFiction, humour"]
    "summary": "It's just very good",
    "chapterContent": [<chapter 1>, <chapter 2>, ...]
  }
  ```
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Document]
])

#slide[
  == Document database concepts

  - _Documents_ are essentially JSON

  - An _index_ is a collection of documents

  - When you search
    - you get back all data that matched
    - with a _relevance score_ for how well it matched
]

#slide[
  == Characteristics of document databases

  - Relatively unstructured data

  - But want indexing

  - And rich querying

  - /*OLTP -*/ Store and query rather than update

  /*
  - No transactions
  */
]

#slide[
  == Document example: OpenSearch®

  #image("images/opensearch_logo_default.svg", height:50pt)


  #quote(
    block: true,
    attribution: [
      #link("https://opensearch.org/")[opensearch.org]
    ],
    [
    OpenSearch is an open-source, enterprise-grade search and observability
    suite that brings order to unstructured data at scale
    ]
  )
]

#slide[
  == More about OpenSearch

  - Technology origins in document processing, indexing and searching for large bodies of text

  - Backed by #link("https://lucene.apache.org/")[Apache Lucene]

  - Queries are written in JSON

  - Schema design up front is optional
    - but sometimes advised

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
  == Queries: Query DSL

  ```python
    query_body = {
      "query": {
        "bool": {
           must": {"match": {"author": "Tibs"}},
           must_not": {"match": {"title": "That Book"}},
        }
      }
    }
    resp = client.search(index=INDEX_NAME, body=query_body)
  ```
]

/*
#slide[
  == Queries: Lucene syntax
  ```python
  client = OpenSearch(SERVICE_URI, use_ssl=True)

  client.search({
      index: 'recipes',
      q: 'author:Tibs AND title: (-That Book)'
  })
  ```
]

#slide[
  == Queries: SQL

  ```
  curl -XPOST https://localhost:9200/_plugins/_sql \
      -u 'admin:<custom-admin-password>'           \
      --insecure                                   \
      -H 'Content-Type: application/json'          \
      -d '{"query": "SELECT * FROM my-index*'      \
         '  WHERE title <> "That Book"}'
  ```

  #align(right)[#text(size: 20pt, fill:gray, [untested code!])]
  ]
  */

#slide[
  == A dashboard about mastodon messages

  #image("images/blog-kafka-mastodon-2-past-15-minutes.png", height: 80%)
]

#slide[
  == When to use a document database

  - Fast, scalable full text search

  - Storage of indexable JSON documents

  - OpenSearch: sophisticated analytics visualisation
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == 4. Key Value


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

      node( (0,0), [author:Tibs], shape: chevron, outset: 5pt ),
      edge("=>"),
      node( (2,0), ['id':273, 'name':'Tibs'], shape: rect, outset: 5pt ),
      node( (0,1), [book:This Book], shape: chevron, outset: 5pt ),
      edge("=>"),
      node( (2,1), align(left)[
        'id': 1,
        'title': 'This Book',\
        'author': 'Tibs'
      ], shape: rect, outset: 5pt ),
      node( (0,2), [book: That Book], shape: chevron, outset: 5pt ),
      edge("=>"),
      node( (2,2), align(left)[
        'id': 2,
        'title': 'That Book',\
        'author': 'Tibs'
      ], shape: rect, outset: 5pt ),
    ),
    caption: [A picture of a dictionary 🙂]
  )
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Key Value]
])

#slide[
  == Characteristics of key value databases

  - Fast

  - Simple

  - Sophisticated value data types

  - Think like a Python dictionary!

]

#slide[
  == Key Value example: Valkey™

  #image("images/valkey-horizontal.svg", height:50pt)

  #quote(
    attribution: [
      #link("https://valkey.io/")[https://valkey.io]
    ],
    [
    Valkey is an open source (BSD) high-performance key/value datastore that
    supports a variety of workloads such as caching, message queues, and can
    act as a primary database.
    ]
  )
]

#slide[
  == Datatypes

  *Key*: a binary sequence

  *Value*:
  #toolbox.side-by-side[
    - Strings
    - Lists
    - Sets and Sorted sets
    - Hashes
    - Streams
  ][
    - Geospatial indexes
    - Bitmaps
    - Bitfields
    - Hyperloglog
    - Bloom filter
    - ...plus extensions
  ]
]

#slide[
  == Queries

  Its own protocol, with its own CLI

  It's actually rather lovely...

  ```
  SET current:greeting "Hello" EX 60
  ```
  ```
  LSET booklist 0 "This Book"
  ```
  ```
  HGET "book:This Book" author
  ```
]

// Use `TYPE key` to find the datatype of the value stored at `key`
// Use `OBJECT ENCODING key` to find out the internal encoding of the Valkey object stored at `key`

#slide[
  == More about Valkey

  - In-memory, but persistent to disk

  - Use cases include:

    - Data storage and retrieval

    - Caching, leveraging the value expiry support

    - Pub/Sub messaging (`SUBSCRIBE`, `UNSUBSCRIBE`, `PUBLISH`)

    - Streams (append-only log) for message queues (`XADD`, `XREAD`)
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
// but Valkey is a sensible option

/*
    "title": "A very good book",
    "author": "Tibs",
    "isbn": null,
    "publisher": "self-published",
    "tags": ["nonFiction, humour"]
    "summary": "It's just very good",
    "chapterContent": [<chapter 1>, <chapter 2>, ...]
*/

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == 5. Graph

  #diagram(

  node-fill: teal.lighten(50%),
  spacing: 1em,

    node( (0,0), [This Book], name: <book1>, shape: pill, outset: 1pt, fill: green),
    node( (9,0), [That Book], name: <book2>, shape: pill, outset: 1pt, fill: green),
    node( (4,2), [Tibs], name: <tibs>, shape: circle, outset: 1pt ),
    node( (4,5), [Alan], name: <alan>, shape: circle, outset: 1pt ),
    node( (8,5), [John], name: <john>, shape: circle, outset: 1pt ),
    edge(<book1>, "->", <tibs>, label: [writtenBy], bend: 10deg, label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<book1>, "->", <tibs>, label: [publishedBy], bend: -10deg,label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<book2>, "->", <john>, label: [writtenBy], label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<book2>, "->", <tibs>, label: [publishedBy], bend: -10deg,label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<john>, "->", <tibs>, label: [actually], label-size: 0.8em, label-sep: 0pt, label-angle: auto),
    edge(<john>, "->", <alan>, label: [actually], label-size: 0.8em, label-sep: 0pt, label-angle: auto),

  )

 *not* an XY data graph 🙂
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[Graph]
])

#slide[
  == Characteristics of graph databases

 _Nodes_, _relationships_ and _properties_

  - or _objects_, _references_ and _attributes_
  - or _nodes_, _edges_ and _values_

  Schemas might be implicit, gradual or designed up-front
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

  - are 1:1 or 1:many or many:1

  - depending on design (I have opinions):
/*
    - *may* be single or bidirectional
*/
    - *may* have properties
]

// Gothic and my own experience, but briefly

// About directed relationshops in Neo4J - the system can "follow" the
// relationship in either direction, they just reckon the overhead of
// making all relationships have names for both directions is too great,
// and it's also too confusing
// https://dzone.com/articles/modelling-data-neo4j
// Given that, and because it's a detail relating to a dead system,
// I've dropped the "single or bidirectional" point

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
      The programmer works with a flexible network structure of nodes and
      relationships rather than static tables — yet enjoys all the benefits of
      enterprise-quality database.
    ]
  )
]

#slide[
  == More about Neo4J nodes

  Nodes

  - have _labels_

  - have key:value properties

  - are indexed
]

// So in my example graph, the labels would be Person and Book

#slide[
  == More about Neo4J relationships

  Relationships

  - have a name

  - must have a type, a start node and an end node

  - must have a direction

  - can have properties
]

#slide[
  == Queries: Neo4J has Cypher

  ```
  CREATE (p:Book
    {name:'This Book'})-[r:IS_WRITTEN_BY]->
      (p:Person {name:'Tibs'}
  )
  ```

  From Neo4J's own examples:
  ```
  MATCH p=shortestPath(
    (bacon:Person {name:"Kevin Bacon"})-[*]-
      (meg:Person {name:"Meg Ryan"})
  ) RETURN p
  ```
]

#slide[
  #image("images/KevinBaconToMegRyan.png")
]

#slide[
  == When to use a graph database

  - You have a knowledge graph shaped puzzle

  - Neo4J: You want to build structures as you learn them

  - Neo4J: You want to leverage existing techniques & solutions
]

#set page(header: context[
  #set text(size: 15pt, fill:gray)
  #align(left)[ ]
])

#slide[
  == Things just about all the shapes give you

  /*
  - Transactions #text(size: 20pt)[(not really OpenSearch)]
  */

  - JSON support

  - Vector embeddings #text(size: 20pt)[(Valkey not yet; SQLite has an extension)]

  - Extensibility
]

// https://neo4j.com/docs/operations-manual/current/database-internals/transaction-management/
// "All modifications performed in a transaction are kept in memory. This
// means that very large updates must be split into several transactions to
// avoid running out of memory."

/*
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
*/

// https://en.wikipedia.org/wiki/ACID
// https://en.wikipedia.org/wiki/CAP_theorem

#slide[
  == What we've looked at

  Five different kinds (shapes) of database

  #table(
    columns: 3,
    align: left,
    inset: 10pt,
    fill: (y, _) =>
      if calc.odd(y) { luma(240) }
      else { white },
    //column-gutter: 2em,
    //row-gutter: 20pt,
    [Relational], [PostgreSQL®], [#text(size: 20pt)[Use for just about anything]],
    [ ], [SQLite], [#text(size: 20pt)[Use in your programs, use locally]],
    [Columnar], [ClickHouse®], [#text(size: 20pt)[Use for analytics, historical data]],
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
  managed versions of PostgreSQL, ClickHouse, Valkey and OpenSearch (and free
  versions of PG and Valkey).
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
