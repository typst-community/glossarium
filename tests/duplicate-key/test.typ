#import "../../themes/default.typ": *
#let entry-list = (
  (
    key: "test",
  ),
  (
    key: "test",
  ),
)
#register-glossary(entry-list)
#show: make-glossary
// #print-glossary(entry-list)
// cannot catch panic :(
