#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux", short: $xi zeta eta$),
  (key: "syscall", short: "system call"),
)
#register-glossary(entry-list)
#show: make-glossary.with(
  //
  user-capitalize: txt => {
    if type(txt) == content and txt.func() == math.equation {
      txt.body.children.filter(x => x != [ ]).join("-")
    } else if type(txt) == str {
      txt.split(" ").map(word => upper(word.at(0)) + word.slice(1)).join(" ")
    } else if type(txt) == none {
      txt
    }
  },
)
#print-glossary(entry-list, show-all: true)

= Tests

@bar, @Bar

@qux, @Qux

@syscall, @Syscall

#gls("syscall"), #Gls("syscall"), #gls("syscall", capitalize: true)
