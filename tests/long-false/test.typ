#import "../../themes/default.typ": *

#set page(height: auto, width: auto)

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

/ long true: #gls("kuleuven", long: true)

/ first form long false: #gls("utc", long: false)

/ second form: #gls("utc")

/ long true: #gls("utc", long: true)

/ first form: #agls("ups")

/ second form: #agls("ups")

/ long true: #agls("ups", long: true)

/ first form: #gls("lorem", plural: true)

/ second form: #gls("lorem", plural: true)

/ long true: #gls("lorem", plural: true, long: true)

/ suffix: #glspl("utc", suffix: "ah")

#print-glossary(entry-list)
