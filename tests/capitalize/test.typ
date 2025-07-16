#import "../../themes/default.typ": *

#show: make-glossary
#let glossary = (
  (key: "foo", long: "foobar"),
  (key: "bar", long: "barbaz"),
  (key: "ref", long: "reference"),
  (key: "test", long: "Test"),
  (key: "plural", long: "longplural", longplural: "longplurali"),
  (key: "POTATO", long: "potato"),
)
#register-glossary(glossary)

#set heading(numbering: "1.")

= Glossary

#glossary

= Some content

#set raw(lang: "typ")
#table(
  columns: 3,
  [Code], [1st], [2nd],
  [`#Gls("foo")`], Gls("foo"), Gls("foo"),
  [`#Glspl("bar")`], Glspl("bar"), Glspl("bar"),
  [`@Ref`], [@Ref], [@Ref],
  // Ref vs ref
  [`@Test:pl`], [@Test:pl], [@Test:pl],
  [`@POTATO`], [@POTATO], [@POTATO],
  // POTATO vs POTATO
  [`@Plural:pl`], [@Plural:pl], [@Plural:pl],
)

= Glossary

#print-glossary(glossary)
