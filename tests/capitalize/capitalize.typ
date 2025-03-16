#import "../../themes/default.typ": *

#show: make-glossary
#let glossary = (
  (key: "NN", short: "NN", long: "Neural Network"),
  (key: "SG", short: "SG", long: "Singular"),
  (key: "foo", long: "foobar"),
)
#register-glossary(glossary)

#set heading(numbering: "1.")

= Some content

#Gls("foo") is a reference at the beginning of a sentence. Use `#Gls("foo")`: `@foo` (@foo) doesn't uppercase.

= Glossary

#print-glossary(glossary)
