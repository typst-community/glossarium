
// @typstyle off
#import "../../glossarium.typ": make-glossary, register-glossary, print-glossary, gls, glspl
// #import "@preview/glossarium:0.5.4": make-glossary, register-glossary, print-glossary, gls, glspl

#show: make-glossary
#let entry-list = (
  (
    key: "potato",
    long: "potato",
    // "plural" will be used when "short" should be pluralized
    longplural: "potatoes",
    description: [#lorem(10)],
  ),
  (
    key: "dm",
    short: "DM",
    long: "diagonal matrix",
    // "longplural" will be used when "long" should be pluralized
    longplural: "diagonal matrices",
    description: "Probably some math stuff idk",
  ),
  (
    key: "cpu",
    short: "CPU",
    long: "Central Processing Unit",
    description: [#lorem(10)],
  ),
  (
    key: "buffer",
    long: "buffer",
    description: "A place to store stuff",
  ),
)
#register-glossary(entry-list)

#set page(paper: "a5")

#show link: set text(fill: blue.darken(60%))

I like to eat #glspl("potato"). Yes I still like to eat #glspl("potato").

But I don't like to eat #glspl("dm").

...

I thought about it and now I like to eat #glspl("dm").

I love #glspl("cpu"). I ate a #gls("cpu") once.

Would you eat a #gls("buffer") ? I heard #glspl("buffer") are tasty.

= Glossary

#print-glossary(
  entry-list,
  // show all term even if they are not referenced, default to false
  show-all: true,
  // disable the back ref at the end of the descriptions
  disable-back-references: true,
)
