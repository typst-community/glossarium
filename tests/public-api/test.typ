#import "../../glossarium.typ": (
  default-capitalize, default-group-break, default-plural,
  default-print-back-references, default-print-description, default-print-gloss,
  default-print-glossary, default-print-group-heading, default-print-reference,
  default-print-title, default-shorthands,
)

// Importing these names through the package entrypoint is the regression test.
#let exported-defaults = (
  default-capitalize,
  default-group-break,
  default-plural,
  default-print-back-references,
  default-print-description,
  default-print-gloss,
  default-print-glossary,
  default-print-group-heading,
  default-print-reference,
  default-print-title,
  default-shorthands,
)
