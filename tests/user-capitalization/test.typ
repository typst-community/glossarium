#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux", short: $xi zeta eta$),
)
#register-glossary(entry-list)
#show: make-glossary.with(
  //
  user-capitalize: txt => {
    if type(txt) == content and txt.func() == math.equation {
      txt.body.children.filter(x => x != [ ]).join("-")
    } else if type(txt) == str {
      upper(txt.at(0)) + txt.slice(1)
    } else if type(txt) == none {
      txt
    }
  },
)
#print-glossary(entry-list, show-all: true)

= Tests

@bar, @Bar

@qux, @Qux
