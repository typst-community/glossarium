#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#context assert.eq(
  catch(() => _style-entries("group", () => nothing)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : style-entries: attribute 'group' is not supported for styling. Use `user-print-group-heading` in `print-glossary` to style groups.\"",
)
