// Test for __entry_has_unknown_keys error message
#import "../../themes/default.typ": *

#let test_entry = (
  key: "testkey",
  short: "Test",
  unknown: "should trigger error",
)

// This should panic with the unknown keys error
// Uncomment the line below to run the test:
#assert.eq(
  catch(() => register-glossary((test_entry,))),
  "panicked with: \"glossarium@" + glossarium_version + " error : entry 'testkey' has unknown keys: unknown\"",
)
