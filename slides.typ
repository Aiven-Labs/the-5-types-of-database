// Get Polylux from the official package repository
#import "@preview/polylux:0.4.0": *

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")
//#set text(size: 25pt, font: "Lato")
#set text(size: 25pt)

// Trying out QR codes
#import "@preview/tiaoma:0.3.0"

// Use #slide to create a slide and style it using your favourite Typst functions
#slide[
  #set align(horizon)
  = Very minimalist slides

  A lazy author

  July 23, 2023

  #grid(
    rows: (auto, auto),
    align: center,
    row-gutter: 10.0pt,
    tiaoma.qrcode("https://aiven.io/tibs", options: (scale: 3.0)),
    [https://aiven.io/tibs]
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
    columns: (40%, auto),
    align: center,
    row-gutter: 10.0pt,
    text(0.8em)[Slides available at https://github.com/Aiven-Labs/the-5-types-of-database],
    tiaoma.qrcode("https://github.com/Aiven-Labs/the-5-types-of-database", options: (scale: 2.0)),
  )

  Slides created using `typst` and `polylux`
]
