#import "../../themes/default.typ": *

#show: make-glossary
#let glossary = (
  (key: "foo", long: "foobar"),
  (key: "bar", long: "barbaz"),
  (key: "ref", long: "reference"),
  (key: "test", long: "Test"),
)
#register-glossary(glossary)

#set heading(numbering: "1.")

= Some content

- #Gls("foo") is the first reference at the beginning of a sentence using `#Gls`.
- #Gls("foo") is the second reference.
- #Glspl("bar") is the first reference at the beginning of a sentence using `#Glspl`.
- #Glspl("bar") is the second reference.
- @Ref is the first reference at the beginning of a sentence using `@Ref`. @Ref is the second.
- @Test:pl is the first reference at the beginning of a sentence using `@Test:pl`. @Test is the second.

= Glossary

#print-glossary(glossary)
