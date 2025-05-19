// https://github.com/typst-community/glossarium/issues/115
#import "../../themes/default.typ": *

#let items = (
  (key: "a", short: "ShortA", long: "Entry A"),
  (key: "b", short: "ShortB", long: "Entry B"),
)

#show: make-glossary
#register-glossary(items)

#set text(size: 12pt)

= Section

@a

#lorem(250)

@b

#lorem(100)
@b

#lorem(100)
@a

#lorem(200)

#print-glossary(items, deduplicate-back-references: true)
