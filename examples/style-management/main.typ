#import "../../glossarium.typ": *

#show: make-glossary

// Define some entries with different default behavior
#let entries-default = (
  (
    key: "cpu",
    short: "CPU",
    long: "Central Processing Unit",
  ),
  (
    key: "ram",
    short: "RAM", 
    long: "Random Access Memory",
  ),
)

// Register with default style (long-short, short)
#register-glossary(entries-default)

= Section 1: Default Style Behavior

First reference to @cpu shows: "Central Processing Unit (CPU)"

Second reference to @cpu shows: "CPU"

First reference to @ram shows: "Random Access Memory (RAM)"

#pagebreak()

// Change the default style for new entries
#context set-default-styles((entry-styles.short-long, entry-styles.short))

#let entries-custom = (
  (
    key: "gpu",
    short: "GPU",
    long: "Graphics Processing Unit",
  ),
  (
    key: "ssd",
    short: "SSD",
    long: "Solid State Drive",
  ),
)

#register-glossary(entries-custom)

= Section 2: Custom Default Style

First reference to @gpu shows: "GPU (Graphics Processing Unit)"

Second reference to @gpu shows: "GPU"

First reference to @ssd shows: "SSD (Solid State Drive)"

#pagebreak()

// Use footnote style for specific entries
#context set-default-styles((entry-styles.footnote, entry-styles.short))

#let entries-footnote = (
  (
    key: "api",
    short: "API",
    long: "Application Programming Interface",
  ),
)

#register-glossary(entries-footnote)

= Section 3: Footnote Style

First reference to @api shows short form with long form in footnote.

Second reference: @api

#pagebreak()

// Update style for a specific entry after registration
#context set-entry-styles(
  ((key: "cpu"),),
  (entry-styles.footnote, entry-styles.short)
)

// Reset counts to see first reference behavior again
#context reset-counts("cpu")

= Section 4: Update Specific Entry Style

After changing CPU to footnote style:

First reference to @cpu now uses footnote style.

Second reference: @cpu

#pagebreak()

= Section 5: Verify Current Default

#context {
  let current = get-default-styles()
  [Current default styles: #current]
  assert.eq(current, (entry-styles.footnote, entry-styles.short))
}

#pagebreak()

= Glossary

#print-glossary(entries-default + entries-custom + entries-footnote, show-all: true)
