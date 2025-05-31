#import "../../themes/default.typ": *
#show: make-glossary
#let entry-list = (
  (
    key: "potato",
    long: "long potato",
    plural: "potatoes",
    longplural: "long potatoes",
    description: [#lorem(5)],
  ),
  (
    key: "recursivepotato",
    long: "long recursive potato",
    plural: "potatoes",
    longplural: "long potatoes",
    description: [#lorem(5) @recursivepotato],
  ),
)
#register-glossary(entry-list)

= Glossary
#print-glossary(entry-list)

= Heading

@potato

@recursivepotato
