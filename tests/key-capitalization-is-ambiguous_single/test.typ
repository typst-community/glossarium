// Test for __key_capitalization_is_ambiguous error message in case of a single glossary
#import "../../themes/default.typ": *

#show: make-glossary

#let test_glossary = (
  (key: "test", long: "Test"),
  (key: "Test", long: "Test"),
)

// https://forum.typst.app/t/why-does-tytanic-not-catch-panic-in-some-cases/4529/3
#context assert.eq(
  catch(() => _register-glossary(test_glossary)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : key 'Test' already exists in the glossary with different capitalization\"",
)
