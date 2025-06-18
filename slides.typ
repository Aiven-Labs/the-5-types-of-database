// Get Polylux from the official package repository
#import "@preview/polylux:0.4.0": *

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")
//#set text(size: 25pt, font: "Lato")
#set text(size: 25pt, font: "Roboto")

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

// Use #slide to create a slide and style it using your favourite Typst functions
#slide[
  #set align(horizon)

  #heading(
    level: 1,
    [Explaining the 5 types of database \
     and how to choose between them]
  )

  #v(20pt)

  Tibs, Product Advocate at Aiven

  18#super[th] July 2025, EuroPython 2025

  #align(right,
  grid(
    rows: (auto, auto),
    align: center,
    row-gutter: 10.0pt,
    tiaoma.qrcode("https://aiven.io/tibs", options: (scale: 3.0)),
    [https://aiven.io/tibs]
  )
  )
]

#slide[
  == Shapes, kinds...
  I think of databases as separated by their *shape*

  ...the way they hold their data

  And that gives me 5 shapes to talk about
]

#slide[
  == The five kinds of database I'll look at

  - Relational
  - Columnar
  - Document
  - Key Value
  - Graph

  with open source examples of each
]

#slide[
  == Relational
]

#slide[
  == Relational example 1: PostgreSQL®

  #image("images/elephant.png", height:100pt)
]

#slide[
  == Relational example 1: sqlite

  #image("images/sqlite370_banner.svg", height:100pt)
]

#slide[
  == Columnar
]

#slide[
  == Columnar example: ClickHouse®

  #image("images/ClickHouse_Logo_Black_FNL.svg", height:100pt)
]

#slide[
  == Document
]

#slide[
  == Document example: OpenSearch®

  #image("images/opensearch_logo_default.svg", height:100pt)
]

#slide[
  == Key Value
]

#slide[
  == Key Value example: Valkey™

  #image("images/valkey-horizontal.svg", height:100pt)
]

#slide[
  == Graph
]

#slide[
  == Graph example: Neo4J®

  #image("images/neo4j-logo.svg", height:100pt)
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


#slide[
  == Fin

  #grid(
    columns: (50%, auto),
    align: left,
    row-gutter: 10.0pt,
    column-gutter: 10.0pt,
    text(0.8em)[
      Slides available at \
      https://github.com/Aiven-Labs/the-5-types-of-database, licensed
      #box(
        baseline: 50%,
        image("images/cc-attribution-sharealike-88x31.png"),
      )
    ],
    tiaoma.qrcode("https://github.com/Aiven-Labs/the-5-types-of-database", options: (scale: 2.0)),
  )

  Slides created using
  #link("https://typst.app/")[typst] and
  #link("https://typst.app/universe/package/polylux/")[polylux]
]
