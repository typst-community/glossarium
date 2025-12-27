#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo", description: "This is the foo entry."),
  (key: "bar", long: "longbar", description: "This is the bar entry."),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#show: make-glossary

#print-glossary(entry-list, show-all: true)

= Tests

@foo

@bar @qux

Reprint foo's entry.
#print-gloss("foo")

Reprint bar's entry.
#print-gloss("bar")
