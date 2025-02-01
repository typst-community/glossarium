
// https://github.com/typst-community/glossarium/issues/55#issuecomment-2388176204
// #import "@preview/glossarium:0.4.1": *
#import "../../themes/default.typ": *
#show: make-glossary

#let glossary-terms = (
  (key: "a", short: "a", long: "A", description: [test a @b]),
  (key: "b", short: "b", long: "B", description: [test b @c]),
  (key: "c", short: "c", long: "C", description: [test c @d]),
  (key: "d", short: "d", long: "D", description: [test d @e]),
  (key: "e", short: "e", long: "E", description: [test e @f]),
  (key: "f", short: "f", long: "F", description: [test f @g]),
  (key: "g", short: "g", long: "G", description: [test g @h]),
  (key: "h", short: "h", long: "H", description: [test h]),
)
#register-glossary(glossary-terms)

@a

@b

@c

= Glossary

#print-glossary(
  glossary-terms,
  user-print-gloss: (entry, ..) => entry.description,
)
