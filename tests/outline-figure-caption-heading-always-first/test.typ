#import "../../themes/default.typ": *

#let entry-list(n) = (
  (
    key: str((n - 1) * 3 + 1),
    long: lorem((n - 1) * 3 + 1).slice(0, -1).replace(" ", ""),
  ),
  (
    key: str((n - 1) * 3 + 2),
    long: lorem((n - 1) * 3 + 2).slice(0, -1).replace(" ", ""),
  ),
  (
    key: str((n - 1) * 3 + 3),
    long: lorem((n - 1) * 3 + 3).slice(0, -1).replace(" ", ""),
  ),
)

#set page(paper: "a5")
#register-glossary(entry-list(1) + entry-list(2) + entry-list(3))

== Test: outline-always-first

#{
  show: make-glossary.with(
    outline-always-first: true,
  )

  outline(target: figure, title: "Figures")
  figure([`outline-always-first: true`], caption: [@1])
}

#{
  show: make-glossary.with(
    outline-always-first: false,
  )

  outline(target: figure, title: "Figures")
  figure([`outline-always-first: false`], caption: [@2])
}

== Test: figure-caption-always-first

#{
  show: make-glossary.with(
    figure-caption-always-first: true,
  )

  figure([`figure-caption-always-first: true`], caption: [@3])
}

#{
  show: make-glossary.with(
    figure-caption-always-first: false,
  )

  figure([`figure-caption-always-first: false`], caption: [@4])
}

== Test: heading-always-first

#{
  show: make-glossary.with(
    heading-always-first: true,
  )

  [=== `heading-always-first: true` @5]
}

#{
  show: make-glossary.with(
    heading-always-first: false,
  )

  [=== `heading-always-first: false` @6]
}

#pagebreak()
= Glossary

#show: make-glossary
#print-glossary(
  (entry-list(1) + entry-list(2) + entry-list(3)),
  show-all: true,
  disable-back-references: true,
)

