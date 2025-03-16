#import "../../themes/default.typ": *

#show: make-glossary
#let glossary = (
  (key: "NN", short: "NN", long: "Neural Network"),
  (key: "SG", short: "SG", long: "Singular"),
)
#register-glossary(glossary)

#set heading(numbering: "1.")

= Some content

Here is some nice content. It even refers to various things (#gls("NN") and @SG) but only in parentheses as well as another one (@label).

== More text <label>

Here is another paragraph with a label.

#print-glossary(glossary)
