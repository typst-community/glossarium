#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#show: make-glossary
#grid(
  columns: 4,
  print-glossary(entry-list, show-all: true),
  {
    context __glossary_entries.get()
    style-entries("short", smallcaps)
  },
  context __glossary_entries.get(),
  print-glossary(entry-list, show-all: true),
)
