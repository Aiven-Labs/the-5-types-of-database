// Get Polylux from the official package repository
#import "@preview/polylux:0.4.0": *

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")
//#set text(size: 25pt, font: "Lato")
#set text(size: 25pt)

// Trying out QR codes
#import "@preview/tiaoma:0.3.0"

// I want URLs to be visibly such - otherwise they'll just be shown as normal text
// #show link: underline
#show link: set text(blue)

// Use #slide to create a slide and style it using your favourite Typst functions
#slide[
  #set align(horizon)

  #heading(
    level: 1,
    [Explaining the 5 types of database \
     and how to choose between them]
  )

  #v(20pt)

  Tibs, Product Evangelist at Aiven

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
  == First slide

  Some static text on this slide.
]

#slide[
  == This slide changes!

  You can always see this.
  // Make use of features like #uncover, #only, and others to create dynamic content
  #uncover(2)[But this appears later!]
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
