#import "../../themes/default.typ": *
#show: make-glossary
#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
    long: "Katholieke Universiteit Leuven",
    description: "A university in Belgium.",
  ),
  // Add more terms
)
#register-glossary(entry-list)

Mention @kuleuven once so the next mentions can use the short form.

Some sentence with @kuleuven, but there is a space in front of the comma.

The same happens when it appears at the end of the sentence: @kuleuven.

#gls("kuleuven")-based startups are out of luck as well.

The Haasrode-#gls("kuleuven")-cooperation.

#print-glossary(
 entry-list
)

