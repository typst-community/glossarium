// Test for __new_key_ambiguous error message
#import "../../themes/default.typ": *

#show: make-glossary

#let test_glossary = (
  (key: "test", long: "Test"),
  (key: "test", long: "Test"),
)

// This should panic with the new_key_ambiguous error
#context assert.eq(
  catch(() => _register-glossary(test_glossary)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : key 'test' already exists in the glossary that is currently being registered. Keys have to be unique.\"",
)
