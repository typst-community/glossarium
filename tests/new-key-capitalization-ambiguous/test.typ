// Test for __new_key_capitalization_ambiguous error message
#import "../../themes/default.typ": *

#let test_glossary = (
  (key: "test", long: "Test"),
  (key: "Test", long: "Test")
)

// This should panic with the new_key_capitalization_ambiguous error
#assert.eq(
  catch(() => register-glossary(test_glossary)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : 'Test' already exists but with different capitalization. Keys have to be unique independently of capitalization.\""
)
