// Test for __longplural_but_not_long error message

#import "../../themes/default.typ": *

#let test_entry = (
  key: "testkey",
  short: "Test",
  longplural: "Testen",
)

// This should panic with the longplural-but-not-long error
// Uncomment the line below to run the test:

#context assert.eq(
  catch(() => _register-glossary((test_entry,))),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : 'testkey' has a longplural attribute but no long attribute. Longplural will not be shown.\"",
)
