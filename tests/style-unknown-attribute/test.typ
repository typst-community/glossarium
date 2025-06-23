#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#context assert.eq(
  catch(() => _style-entries("ah", () => nothing)),
  "panicked with: \"glossarium@" + glossarium_version + " error : style-entries: unknown attribute 'ah' for styling.\"",
)
