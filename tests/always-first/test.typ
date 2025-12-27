#import "../../themes/default.typ": *

== always-first

#show: make-glossary.with(always-first: true)
#let entry-list-8 = (
  (
    key: "short",
    long: "long",
  ),
)
#register-glossary(entry-list-8)

1st: @short

2nd: @short

#print-glossary(entry-list-8)
