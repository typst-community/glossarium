#import "../../themes/default.typ": *

#show: make-glossary
#show link: set text(fill: red)
#let entry-list-0 = (
  (
    key: "potato",
    short: "potato",
    long: "long potato",
    plural: "potatoes",
    longplural: "long potatoes",
    description: [#lorem(5)],
  ),
)
#let entry-list-1 = (
  (
    key: "potato A",
    short: "potato@A",
    plural: "potatoes@A",
    description: [#lorem(5)],
    group: "A",
  ),
  (
    key: "potato B",
    short: "potato@B",
    long: "long potato@B",
    plural: "potatoes@B",
    longplural: "long potatoes@B",
    description: [#lorem(5)],
    group: "B",
  ),
  (
    key: "hidden potato",
    short: "hiddenpotato",
    group: "show-all test",
    description: [This potato does not appear, unless `print-glossary` is called with `show-all: true`],
  ),
)
#let entry-list-2 = (
  (
    key: "potato C",
    short: "potato@C",
    long: "long potato@C",
    plural: "potatoes@C",
    longplural: "long potatoes@C",
    description: [#lorem(5)],
    group: "C",
  ),
  (
    key: "potato D",
    short: "potato@D",
    long: "long potato@D",
    plural: "potatoes@D",
    description: [#lorem(5)],
    group: "D",
  ),
  (
    key: "potato E",
    short: "potato@E",
    long: "long potato@E",
    longplural: "long potatoes@E",
    description: [#lorem(5)],
    group: "E",
  ),
  (
    key: "potato F",
    short: "potato@F",
    long: "long potato@F",
    longplural: "long potatoes@F",
    description: [This potato should not appear in the document.],
    group: "F",
  ),
)
#let entry-list-3 = (
  (
    key: "potato G",
    short: "potato@G",
    long: "long potato@G",
    longplural: "long potatoes@G",
    description: [This potato should appear in the document.],
    group: "G",
  ),
)

= Normalization
#set text(size: 8pt)
#columns(2)[
  == entry-list-0

  #entry-list-0

  == entry-list-1

  #entry-list-1

  == entry-list-2
  #entry-list-2

  #colbreak()

  == #repr(__normalize_entry_list) n°0

  #__normalize_entry_list(entry-list-0)

  == #repr(__normalize_entry_list) n°1

  #__normalize_entry_list(entry-list-1)

  == #repr(__normalize_entry_list) n°2

  #__normalize_entry_list(entry-list-2)
]

#pagebreak()

= User API

== ref

`@potato`: @potato

`@potato:pl`: @potato:pl

== #gls

First: #gls("potato")

Display: #gls("potato", display: "potato text")

Force long: #gls("potato", long: true)

1st ref. when long is empty defaults to short: #gls("potato A")

Force long when empty defaults to short: #gls("potato A", long: true)

2nd ref.: #gls("potato A")

1st ref.: #gls("potato B")

== #glspl

First: #glspl("potato C")

Force long: #glspl("potato", long: true)

Force long when empty defaults to plural: #glspl("potato A", long: true)

2nd ref.: #glspl("potato A")

1st ref. when long is empty defaults to plural: #glspl("potato B")

1st ref. when longplural is empty: #glspl("potato D")

2nd ref. when longplural is empty: #glspl("potato D")

1st ref. when plural is empty: #glspl("potato E")

== #gls-description

#gls-description("potato B")

== #gls-key

#gls-key("potato C")

== #gls-short

#gls-short("potato D")

== #gls-plural

#gls-plural("potato A")

== #gls-longplural

#gls-longplural("potato B")

== `gls-longplural.with(link: true)`

#gls-longplural.with(link: true)("potato B")

== #gls-description

#gls-description("potato C")

== #gls-group

#gls-group("potato D")

#pagebreak()

#columns(2)[
  == `#print-glossary.with(show-all: true, disable-back-references: true)`

  #print-glossary(
    entry-list-0,
    show-all: true,
    disable-back-references: true,
  )

  #print-glossary(
    entry-list-1,
    show-all: true,
    disable-back-references: true,
  )

  #colbreak()

  == #repr(print-glossary) (show-all: false)

  #print-glossary(
    entry-list-2,
    show-all: false,
    disable-back-references: false,
  )

  #print-glossary(
    entry-list-3,
    show-all: true,
    disable-back-references: false,
    user-group-break: colbreak,
  )

  == `#default-print-reference.with(show-all: true)`

  Forcibly print nonreference entry.

  #default-print-reference.with(show-all: true)(entry-list-2.last())

]
