#import "../../themes/default.typ": *
#let glossary = (
  (
    key: "tum",
    group: "Universities",
  ),
)

#set heading(numbering: "1")

#show: make-glossary

#register-glossary(glossary)

// #outline() // do not need for the divergence test
Foo @tum

// #print-glossary(glossary, minimum-refs: 1) // diverges
#print-glossary(glossary, minimum-refs: 0) // converges
