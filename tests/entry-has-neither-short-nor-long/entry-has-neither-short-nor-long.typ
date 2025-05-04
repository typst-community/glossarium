// Test for __entry_has_neither_short_nor_long error message

#import "../../themes/default.typ": register-glossary

#let test_entry = (
  key: "testkey",
  // No 'short' and no 'long'
)

// This should panic with the entry_has_neither_short_nor_long error
// Uncomment the line below to run the test:
#register-glossary((test_entry,), use-key-as-short: false)
