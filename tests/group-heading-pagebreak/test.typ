// #import "@preview/glossarium:0.5.3": make-glossary, register-glossary, print-glossary, gls
#import "../../themes/default.typ": *
#let abbreviations = (
  (
    key: "Abbr",
    short: "Abbr",
    group: "Group",
  ),
)
#set page(paper: "a8")
#show: make-glossary
#register-glossary(abbreviations)
@Abbr                            // Here also diverges
#set page(numbering: "1")

#v(55%)
#outline()

#pagebreak()
@Abbr // Here also diverges,
#gls("Abbr") // AND the same happens with #gls()
#print-glossary(
  abbreviations,
  // show-all: true// Uncommenting this makes the error disappear
)

= Chapter
= Chapter
= Chapter
= Chapter

@Abbr
#gls("Abbr") // Using this instead of or in addition to the previous line makes the error disappear
