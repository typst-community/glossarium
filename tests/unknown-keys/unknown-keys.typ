// Test for __entry_has_unknown_keys error message
#import "../../themes/default.typ": *

#let test_entry = (
  key: "testkey",
  short: "Test",
  unknown: "should trigger error",
)

// This should panic with the unknown keys error
// Uncomment the line below to run the test:
#register-glossary((test_entry,))
