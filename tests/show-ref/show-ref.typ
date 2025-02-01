#import "../../themes/default.typ": *

#show: make-glossary
// Apply show ref rule after make-glossary
#show ref: it => {
  let el = it.element
  if el != none and el.func() == figure and el.kind == "glossarium_entry" {
    // Make the glossarium entry references dark blue
    text(red, it)
  } else {
    // Other references as usual.
    it
  }
}

#let glossary = (
  (key: "NN", short: "NN", long: "Neural Network"),
  (key: "SG", short: "SG", long: "Singular"),
)

#register-glossary(glossary)
#print-glossary(glossary)

#link("https://example.com")[Test Link]

@NN
@SG
