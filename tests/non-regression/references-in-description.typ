// https://github.com/typst-community/glossarium/issues/55#issuecomment-2388176204
// #import "@preview/glossarium:0.4.1": make-glossary, print-glossary, gls, glspl
#import "../../themes/default.typ": *
#show: make-glossary

#let glossary-terms = (
  (key: "a", short: "a", long: "A", desc: [test a @b]),
  (key: "b", short: "b", long: "B", desc: [test b @c]),
  (key: "c", short: "c", long: "C", desc: [test c @d]),
  (key: "d", short: "d", long: "D", desc: [test d @e]),
  (key: "e", short: "e", long: "E", desc: [test e]),
)
// #register-glossary(glossary-terms)

@a

@b

// @c

#print-glossary(glossary-terms)
