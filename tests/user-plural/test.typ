#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#show: make-glossary.with(
  //
  user-plural: txt => txt + "z",
)
#print-glossary(entry-list, show-all: true)

@bar:pl

@qux:pl
