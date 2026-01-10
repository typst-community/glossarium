#import "../../themes/default.typ": *

#show: make-glossary

// Test 1: Default behavior (long-short, short)
#let entry-list-1 = (
  (
    key: "default-test",
    long: "Default Long Form",
    short: "DLF",
  ),
)
#register-glossary(entry-list-1)

= Test 1: Default Styles (long-short, short)
First occurrence: @default-test

Second occurrence: @default-test

#context reset-counts()

// Test 2: Set default styles to (short-long, short)
#context set-default-styles((entry-styles.short-long, entry-styles.short))

#let entry-list-2 = (
  (
    key: "custom-default",
    long: "Custom Default Long",
    short: "CDL",
  ),
)
#register-glossary(entry-list-2)

= Test 2: Custom Default Styles (short-long, short)
First occurrence: @custom-default

Second occurrence: @custom-default

#context reset-counts()

// Test 3: Set default styles to footnote
#context set-default-styles((entry-styles.footnote, entry-styles.short))

#let entry-list-3 = (
  (
    key: "footnote-default",
    long: "Footnote Default Long",
    short: "FDL",
  ),
)
#register-glossary(entry-list-3)

= Test 3: Footnote Default Style
First occurrence: @footnote-default

Second occurrence: @footnote-default

#context reset-counts()

// Test 4: Set styles for specific entries after registration
#let entry-list-4 = (
  (
    key: "entry-a",
    long: "Entry A Long",
    short: "EA",
  ),
  (
    key: "entry-b",
    long: "Entry B Long",
    short: "EB",
  ),
)
#register-glossary(entry-list-4)

// Change entry-a to use footnote style
#context set-entry-styles(((key: "entry-a"),), (entry-styles.footnote, entry-styles.short))

= Test 4: Set Styles for Specific Entries
Entry A (should be footnote): @entry-a

Entry B (should use default): @entry-b

Second occurrences:
@entry-a
@entry-b

// Test 5: Get current default styles
#context {
  let current-styles = get-default-styles()
  assert.eq(current-styles, (entry-styles.footnote, entry-styles.short))
}

= Glossary
#print-glossary(entry-list-1 + entry-list-2 + entry-list-3 + entry-list-4)
