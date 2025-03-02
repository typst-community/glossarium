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
#let entry-list-4 = (
  (
    key: "potato H",
    short: "potato@H",
    description: [This potato only has a short key.],
  ),
  (
    key: "potato I",
    long: "long potato@I",
    description: [This potato only has a long key.],
  ),
)
#let entry-list-5 = (
  (
    key: "potato J",
    description: [This potato has neither a short nor a long key.],
  ),
)
#for entries in (
  entry-list-0,
  entry-list-1,
  entry-list-2,
  entry-list-3,
  entry-list-4,
) {
  register-glossary(entries)
}

= Typst Compiler Version: #sys.version, #type(sys.version)

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

== #count-refs

#context count-refs("potato D")

== #count-all-refs

All refs: #context count-all-refs()

Only list 4: #context count-all-refs(entry-list: entry-list-4)

== #there-are-refs

true: #context there-are-refs()
)
false: #context there-are-refs(groups: (" ",))

#context if there-are-refs(entry-list: ((key: "potato A"),)) [
  There are refs to potato A in the document.
] else [
  There are no refs to potato A in the document.
]

== test `__attribute_is_empty` error

// #gls-long("potato A")

== test `__key_not_found` error

// #gls("potato Z")

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

  == Test `#print-glossary(none)` error

  // #print-glossary(none)

  == Test only short/long

  #print-glossary(
    entry-list-4,
    show-all: true,
    disable-back-references: true,
  )

  #gls("potato I")

  #glspl("potato I")

  #agls("potato I")

  #gls("potato H")

  #agls("potato H")

  #glspl("potato H")

  == Test neither short nor long error

  // #register-glossary(entry-list-5)

  == `#default-print-reference.with(show-all: true)`

  Forcibly print nonreference entry.

  #context default-print-reference.with(show-all: true)(entry-list-2.last())

  == Test use-key-as-short

  #let entry-list-6 = ((key: "potato-use-key-as-short"),)
  #register-glossary(entry-list-6)
  #print-glossary(entry-list-6)
  @potato-use-key-as-short

]
