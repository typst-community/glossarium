#import "../../themes/default.typ": *
#import "@preview/codly:1.1.1": *
#show: codly-init.with()
#set page(height: auto, margin: 10pt)

#show link: set text(fill: red)
#let entry-list = (
  (
    key: "potato",
    short: "potato",
    long: "long potato",
    plural: "potatoes",
    longplural: "long potatoes",
    description: [#lorem(5)],
  ),
)
#register-glossary(entry-list)

#rect(stroke: 1pt + green, fill: green.lighten(90%))[
  = #sym.checkmark User figure show rule before make-glossary
  #show figure: it => {
    align(right, it.body)
  }
  #show: make-glossary

  ```typc
  show figure: it => {
    align(right, it.body)
  }
  show: make-glossary
  ```
  #rect(width: 100%)[
    #print-glossary(entry-list, show-all: true)
    #figure[Figure Right]
  ]
]

#rect(stroke: 1pt + red, fill: red.lighten(90%))[
  = #sym.crossmark User figure show rule after make-glossary

  #show: make-glossary
  #show figure: it => {
    align(right, it.body)
  }

  ```typc
  show: make-glossary
  show figure: it => {
    align(right, it.body)
  }
  ```
  #rect(width: 100%)[
    #print-glossary(entry-list, show-all: true)
    #figure[Figure Right]
  ]
]
