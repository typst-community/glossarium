#import "../../themes/default.typ": *
#import "@preview/codly:1.3.0": *
#show: codly-init.with()
#set page(height: auto, margin: 10pt)
#show: make-glossary
#let glossary = (
  (key: "NN", short: "NN", long: "Neural Network"),
  (key: "SG", short: "SG", long: "Singular"),
)
#register-glossary(glossary)

#[
  #show: make-glossary
  #show ref: it => {
    let el = it.element
    if el != none and el.func() == figure and el.kind == "glossarium_entry" {
      // Make the glossarium entry references dark blue
      text(fill: blue, it)
    } else {
      // Other references as usual.
      it
    }
  }
  #show link: set text(fill: red)
  // show-set link rule overwrites link styling in ref
  // text(fill: red, it) instead

  = show-set link overwrites link styling in ref

  ```typc
  show: make-glossary
  show ref: ...
  show link: set text(fill: red)
  ```

  link: #link("https://example.com")[Test Link]

  glossarium: @NN
]

#[
  #show: make-glossary
  #show ref: it => {
    let el = it.element
    if el != none and el.func() == figure and el.kind == "glossarium_entry" {
      // Make the glossarium entry references dark blue
      text(fill: blue, it)
    } else {
      // Other references as usual.
      it
    }
  }
  #show link: it => {
    if type(it.dest) == str {
      text(fill: red, it)
    } else {
      it
    }
  }

  = a more specific show link rule prevents overwriting unwanted links

  ```typc
  show: make-glossary
  show ref: ...
  #show link: it => {
    if type(it.dest) == str {
      text(fill: red, it)
    } else {
      it
    }
  }
  ```

  link: #link("https://example.com")[Test Link]

  glossarium: @SG
]


= Glossary
#print-glossary(glossary)
