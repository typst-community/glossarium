#import "../../themes/default.typ": *

#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
    long: "Katholieke Universiteit Leuven",
    longplural: "Katholieke Universiteiten Leuven",
    description: [Fugiat do fugiat est minim ullamco est eu duis minim nisi
      tempor adipisicing do _sunt_.],
    plural: "KU Leuvens",
    artshort: "the",
    artlong: "the",
  ),
  (
    key: "foo",
    short: "foo",
    long: "foo example",
  ),
  (
    key: "bar",
    short: "bar",
    long: "bar example",
  ),
)
#show: make-glossary.with(
  always-long: none,
  outline-always-long: false,
  figure-caption-always-long: false,
  heading-always-long: false,
)

#register-glossary(entry-list)

#set page(paper: "a5")

```typ
#show: make-glossary.with(
  always-long: none,
  outline-always-long: true,
  figure-caption-always-long: false,
  heading-always-long: true,
)
```

#outline(
  target: figure,
  title: "Index of beautiful pictures",
)

#figure(
  emph("*image*"),
  caption: [@kuleuven / @foo],
)

#figure(
  emph("*image*"),
  caption: [@kuleuven / @bar],
)

#outline()

This also works for headings!

= @foo

#pagebreak()

= Glossary

#print-glossary(
  entry-list,
  // show all term even if they are not referenced, default to true
  show-all: true,
  // disable the back ref at the end of the descriptions
  disable-back-references: true,
)
