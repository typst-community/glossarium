#import "../../themes/default.typ": *

#show: make-glossary
#let glossary = (
  (key: "foo", long: "foobar"),
  (key: "bar", long: "barbaz"),
)
#register-glossary(glossary)

#set heading(numbering: "1.")

= Some content

- #Gls("foo") is the first reference at the beginning of a sentence using `#Gls`.
- #Gls("foo") is the second reference.
- #Glspl("bar") is the first reference at the beginning of a sentence using `#Glspl`.
- #Glspl("bar") is the second reference.

= Glossary

#print-glossary(glossary)
