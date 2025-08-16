
// @typstyle off
#import "../../glossarium.typ": make-glossary, register-glossary, print-glossary, gls, glspl
// #import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl
#show: make-glossary
#let entry-list = (
  (
    key: "ntc",
    short: "NTC",
    long: "Linear Transform Coding",
    description: [This is the opposite of @ltc.],
    group: "Nonlinear",
  ),
  (
    key: "ltc",
    short: "LTC",
    long: "This is the opposite of @ltc.",
    description: [Transform Coding constraint to linear transforms.],
    group: "Linear",
  ),
  (
    key: "bor",
    short: "DEF",
    long: "Default",
    description: lorem(25),
  ),
  (
    key: "bor2",
    short: "DEF2",
    long: "Default2",
    description: lorem(25),
    group: "", // Please note that an empty group has the same effect as no group
  ),
)
#register-glossary(entry-list)

#set page(paper: "a5")

//I recommend setting a show rule for the links to that your reader understand that they can click on the references to go to the term in the glossary.
#show link: set text(fill: blue.darken(60%))

= Groups example

Reference to @ntc \
Reference to @bor

#pagebreak()

= Glossary with group enabled

#print-glossary(
  entry-list,
  show-all: true,
)

= Glossary with custom group heading level

#let entry-list-2 = (
  (
    key: "A",
    short: "A",
    group: "Group A",
  ),
  (
    key: "B",
    short: "B",
    group: "Group B",
  ),
)
#register-glossary(entry-list-2)

Reference to @A
Reference to @B

#print-glossary(
  entry-list-2,
  show-all: true,
  group-heading-level: 3,
)

= Glossary with custom group display

#let entry-list-3 = (
  (
    key: "C",
    short: "C",
    group: "Group C",
  ),
  (
    key: "D",
    short: "D",
    group: "Group D",
  ),
  (
    key: "E",
    short: "E",
  ),
)
#register-glossary(entry-list-3)

// Reference to @C // Error: Reference to @C not found
// Reference to @D // Error: Reference to @D not found
Reference to @E (no group)

== Show default group

#print-glossary(
  entry-list-3,
  groups: ("",),
  show-all: true,
)

== Show Group C and Group D

#print-glossary(
  entry-list-3,
  groups: ("Group C", "Group D"),
  show-all: true,
)
