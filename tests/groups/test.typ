#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo", group: "Group 1"),
  (key: "bar", group: "Group 2"),
  (key: "baz", group: "Group 3"),
  (key: "qux", group: "Group 4"),
)
#register-glossary(entry-list)
#show: make-glossary
#print-glossary(entry-list, show-all: true)
