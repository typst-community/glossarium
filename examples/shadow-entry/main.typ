#import "../../glossarium.typ": make-glossary, print-glossary, gls, glspl, agls
#import "../../themes/default.typ": __query_labels_with_key, __link_and_label, default-print-reference, __is_first_or_long
// Replace the local import with a import to the preview namespace.
// If you don't know what that mean, please go read typst documentation on how to import packages at https://typst.app/docs/packages/.

#show: make-glossary

#set page(paper: "a5")

#show link: set text(fill: blue.darken(60%))

= Glossary

Short shadow \
#gls("cpu", shadow: true) 

Long shadow \
#gls("cpu", shadow: true, long: true) 

Plural shadow \
#glspl("cpu", shadow: true, long: true) 

Shadow with article \
#agls("cpu", shadow: true)

Long Shadow with article \
#agls("cpu", shadow: true, long: true)

First mention of unshadowed \
#gls("cpu", ) 

Regular reference \
#gls("cpu", ) 

#print-glossary(
  (
    (
      key: "cpu",
      short: "CPU",
      art: "the",
      long: "Central Processing Unit",
      description: [#lorem(10)],
    ),
  ),
)
