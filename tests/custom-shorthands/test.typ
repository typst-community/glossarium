#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo", long: "foo", longplural: "foos"),
  (key: "bar", description: "bar description"),
  (key: "baz", short: "baz short"),
  (key: "qux", long: "qux long"),
)
#register-glossary(entry-list)
#show: make-glossary
#print-glossary(
  //
  entry-list,
  show-all: true,
  shorthands: (
    "plural",
    "capitalize",
    "capitalize-plural",
    "short",
    "long",
    "description",
    "longplural",
  ),
)

= Foo

@foo @foo:pl @foo:short @foo:long @foo:longplural

= Bar

@bar:description

= Baz

@baz:short

= Qux

@qux

@qux:long

@qux
