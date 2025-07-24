#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "qux", description: [This is a description #gls("foo") #gls("bar")]),
  // (key: "qux", description: [This is a description @foo @bar]),
)
#register-glossary(entry-list)
#show: make-glossary

#print-glossary(entry-list, disable-back-references: true)

@qux
