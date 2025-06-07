#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
// #style-entries("short", none)
// panic
