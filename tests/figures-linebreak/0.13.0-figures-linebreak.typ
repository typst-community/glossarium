
// https://github.com/typst-community/glossarium/issues/101
#import "../../themes/default.typ": *
#show: make-glossary
#let glossary-terms = (
  (key: "a", short: "a", long: "A", description: [test a]),
  (key: "b", short: "b", long: "B", description: [test b]),
  (key: "c", short: "c", long: "C", description: [test c]),
)
#register-glossary(glossary-terms)
#let print-reference(
  entry,
  show-all: false,
  disable-back-references: false,
  minimum-refs: 1,
  user-print-gloss: default-print-gloss,
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = {
  // #set par(
  //   hanging-indent: 1em,
  //   first-line-indent: 0em,
  // )
  [
    #figure(
      supplement: "",
      kind: __glossarium_figure,
      numbering: none,
      caption: user-print-gloss(
        entry,
        show-all: show-all,
        disable-back-references: disable-back-references,
        minimum-refs: minimum-refs,
        user-print-title: user-print-title,
        user-print-description: user-print-description,
        user-print-back-references: user-print-back-references,
      ),
    )[]
    #label(entry.key)
  ]
}

// @a
// @c

= Glossary
#let gls(l) = [
  #metadata(l)
  #label(l)
]

// #print-glossary(glossary-terms, user-print-reference: print-reference)

#gls("lorem")
// #gls("ipsum")
#gls("dolor")
#let q(l) = {
  if query(l).len() > 0 {
    true
  } else {
    false
  }
}
#table(
  columns: 2,
  "body", "caption",
  {
    show figure: f => align(start, f.body)
    [#figure(
        supplement: "",
        numbering: none,
        kind: "glossarium",
        caption: "",
        context if q(<lorem>) { [Lorem] },
      )]
    [#figure(
        supplement: "",
        numbering: none,
        kind: "glossarium",
        caption: "",
        context if q(<ipsum>) { [Ipsum] },
      )]
    [#figure(
        supplement: "",
        numbering: none,
        kind: "glossarium",
        caption: "",
        context if q(<dolor>) { [Dolor] },
      )]
  },
  {
    show figure: f => align(start, f.caption)
    [#figure(
        supplement: "",
        numbering: none,
        kind: "glossarium",
        caption: context if q(<lorem>) { [Lorem] },
      )[]]
    [#figure(
        supplement: "",
        numbering: none,
        kind: "glossarium",
        caption: context if q(<ipsum>) { [Ipsum] },
      )[]]
    [#figure(
        supplement: "",
        numbering: none,
        kind: "glossarium",
        caption: context if q(<dolor>) { [Dolor] },
      )[]]
  },
)
