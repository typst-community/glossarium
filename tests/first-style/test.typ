#import "../../themes/default.typ": *

#show: make-glossary
#let entry-list = (
  (
    key: "no-first-style",
    long: "I have no first style... or do I?",
    short: "no-first-style",
  ),
  (
    key: "first-style-reversed",
    long: "I have a reversed first style",
    short: "first-style-reversed",
    first-style: "reversed"
  ),
  (
    key: "first-style-footnote",
    long: "I have a footnote first style",
    short: "first-style-footnote",
    first-style: "footnote"
  ),
  (
    key: "unknown-first-style",
    long: "I have an unknown first style",
    short: "unknown-first-style",
    first-style: "unknown"
  ),
)
#register-glossary(entry-list)

= Correctly Handle First Occurrences

@no-first-style

@first-style-reversed

@first-style-footnote

= Correctly Handle Second Occurrences

@no-first-style

@first-style-reversed

@first-style-footnote

= Correctly Handle First Occurrences With Overridden `first-style`s

#context {
  reset-counts()
}

#gls(first-style: "footnote", "no-first-style")

#gls(first-style: "footnote", "no-first-style")

= Correctly Handle Unknown `first-style`s

// FIXME: This test does not work at the moment for some reason

// #context assert.eq(
//   catch(() => gls("unknown-first-style")),
//   "panicked with: \"glossarium@" + glossarium_version + " error : entry 'unknown-first-style' has an unknown first-style: unknown\"",
// )

#v(1fr)

#print-glossary(entry-list)
