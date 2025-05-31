#import "../../themes/default.typ": *
#show: make-glossary
#let entry-list = (
  (
    key: "potato",
    short: "potato",
    long: "long potato",
    plural: "potatoes",
    longplural: "long potatoes",
    description: [#lorem(5)],
  ),
)
#register-glossary(entry-list)
#print-glossary(entry-list)
