#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#context assert.eq(
  catch(() => _style-entries("short", none)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : style-entries: style is not a function. Use a function to style the entries.\"",
)

