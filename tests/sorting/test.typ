#import "../../themes/default.typ": *
#show: make-glossary

#let glossary-terms = (
  (key: "b", short: "b", long: "B", sort: 1),
  (key: "a", short: "a", long: "A", sort: 1),
  (key: "c", short: "c", long: "C", sort: 1),
  (key: "e", short: "e", long: "E", sort: 0),
  (key: "d", short: "d", long: "D", sort: 0),
  (key: "f", short: "f", long: "F", sort: -1),
  (key: "g", short: "g", long: "G", sort: -1),
  (key: "h", short: "h", long: "H", sort: -1),
)
#register-glossary(glossary-terms)

= Glossary list
#glossary-terms

#columns(2)[

  = Sorting by sort
  #print-glossary(glossary-terms, show-all: true)

  = Sorting by key
  #print-glossary(glossary-terms, show-all: true, entry-sortkey: e => e.key)

  = Sorting by short
  #print-glossary(glossary-terms, show-all: true, entry-sortkey: e => e.short)

  = Sorting by (sort, key, long)
  #print-glossary(glossary-terms, show-all: true, entry-sortkey: e => (e.sort, e.key, e.long))

]
