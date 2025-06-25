#import "../../themes/default.typ": *

== no reference link
#show link: set text(fill: red)
#show: make-glossary.with(link: false)
#let entry-list-9 = ((key: "no-link"), (key: "with-link"))
#register-glossary(entry-list-9)
@no-link

#show: make-glossary.with(link: true)
@with-link
#print-glossary(entry-list-9)
