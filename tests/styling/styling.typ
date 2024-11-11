#import "../../themes/default.typ": *

#show: make-glossary
#show link: set text(fill: red)
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
#show figure.caption.where(kind: "glossarium_entry"): it => {
  align(center, it)
}

#print-glossary(entry-list, show-all: true)
