
// @typstyle off
#import "../../glossarium.typ": make-glossary, register-glossary, print-glossary, gls, glspl, agls, gls-key, gls-short, gls-artshort, gls-plural, gls-long, gls-artlong, gls-longplural, gls-description, gls-group
// #import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl, agls, gls-key, gls-short, gls-artshort, gls-plural, gls-long, gls-artlong, gls-longplural, gls-description, gls-group
#show: make-glossary
#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
    long: "Katholieke Universiteit Leuven",
    longplural: "Katholieke Universiteiten Leuven",
    description: [Fugiat do fugiat est minim ullamco est eu duis minim nisi tempor adipisicing do _sunt_.],
    plural: "KU Leuvens",
    artshort: "the",
    artlong: "the",
  ),
  (
    key: "foo",
    short: "foo",
    long: "foo example",
  ),
)
#register-glossary(entry-list)

#set page(paper: "a5")

//I recommend setting a show rule for the links to that your reader understand that they can click on the references to go to the term in the glossary.
#show link: set text(fill: blue.darken(60%))

Hello there, I'm showing you some beautiful pictures of a university.

#outline(
  target: figure,
  title: "Index of beautiful pictures",
)

#figure(
  emph("*image*"),
  caption: [Here you can see a beautiful picture of @kuleuven],
)

#figure(
  emph("*image*"),
  caption: [Here you can see another beautiful picture of @kuleuven],
)

This also works for headings!

= @foo

#outline()

#pagebreak()

= Glossary

#print-glossary(
  entry-list,
  // show all term even if they are not referenced, default to true
  show-all: true,
  // disable the back ref at the end of the descriptions
  disable-back-references: true,
)
