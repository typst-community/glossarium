#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux", group: "Group 1"),
)
#set page(width: auto, height: auto)
#register-glossary(entry-list)
#show: make-glossary
#let glossary = print-glossary(
  entry-list,
  show-all: true,
  invisible: true,
)
#context {
  let size = measure(glossary)
  assert.eq(size.width, 0pt)
  assert.eq(size.height, 0pt)
}
