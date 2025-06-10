// Test for __existing_key_capitalization_ambiguous error message
#import "../../themes/default.typ": *

#show: make-glossary

#let test_glossary = (
  (key: "test", long: "Test"),
  (key: "Mouse", long: "Test")
)
#let test_glossary_2 = (
  (key: "Test", long: "Test"),
  (key: "Elephant", long: "Test"),
)

#register-glossary(test_glossary)

// This should panic with the existing_key_capitalization_ambiguous error
#assert.eq(
  catch(() => register-glossary(test_glossary_2)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : 'Test' already exists but with different capitalization in one of the previous registered glossaries. Keys have to be unique independently of capitalization among all glossaries.\""
)
