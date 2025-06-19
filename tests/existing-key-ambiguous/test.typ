// Test for __existing_key_ambiguous error message
#import "../../themes/default.typ": *

#let test_glossary = (
  (key: "test", long: "Test"),
  (key: "Mouse", long: "Test"),
)

#let test_glossary_2 = (
  (key: "test", long: "Test"),
  (key: "Elephant", long: "Test"),
)

#register-glossary(test_glossary)

// This should panic with the existing_key_ambiguous error
#context assert.eq(
  catch(() => _register-glossary(test_glossary_2)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : key 'test' already exists in one of the previous registered glossaries. Keys have to be unique among all glossaries.\"",
)
