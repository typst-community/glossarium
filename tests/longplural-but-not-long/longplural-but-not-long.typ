// Test for __longplural_but_not_long error message

#import "../../themes/default.typ": register-glossary

#let test_entry = (
  key: "testkey",
  short: "Test",
  longplural: "Testen",
)

// This should panic with the longplural-but-not-long error
// Uncomment the line below to run the test:
#register-glossary((test_entry,))
