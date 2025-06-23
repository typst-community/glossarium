// Test for __entry_has_neither_short_nor_long error message

#import "../../themes/default.typ": *

#let test_entry = (
  key: "testkey",
  // No 'short' and no 'long'
)

// This should panic with the entry_has_neither_short_nor_long error
// Uncomment the line below to run the test:
// https://tingerrr.github.io/tytanic/reference/tests/lib.html
#context assert.eq(
  catch(() => _register-glossary((test_entry,), use-key-as-short: false)),
  "panicked with: \"glossarium@" + glossarium_version + " error : entry 'testkey' has neither short nor long form\"",
)
