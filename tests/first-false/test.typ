#import "../../themes/default.typ": *

#set page(height: 15cm, width: 13cm)

#show: make-glossary

#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
    long: "Katholieke Universiteit Leuven",
  ),
  (
    key: "utc",
    short: "UTC",
    long: "Université de Technologie de Compiègne",
  ),
  (
    key: "ups",
    short: "UPS",
    long: "Université Paris-Saclay",
    artshort: "the",
    artlong: "THE",
  ),
  (
    key: "lorem",
    short: "SHORT",
    long: "LONG",
    plural: "shortplural",
    longplural: "longplural",
  ),
)
#register-glossary(entry-list)

/ first form: #gls("kuleuven")

/ second ref: #gls("kuleuven")

/ first  true: #gls("kuleuven", first: true)

/ first form long false: #gls("utc", first: false)

/ second form: #gls("utc")

/ first true: #gls("utc", first: true)
/ first form: #agls("ups")

/ second form: #agls("ups")

/ first true: #agls("ups", first: true)

/ first form: #gls("lorem", plural: true)

/ second form: #gls("lorem", plural: true)

/ first true: #gls("lorem", plural: true, first: true)

/ suffix: #glspl("utc", suffix: "ah")

#print-glossary(entry-list)
