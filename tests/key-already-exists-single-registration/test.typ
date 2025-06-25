// Test for __key_already_exists error message in case of a single glossary
#import "../../themes/default.typ": *
#let entry-list = (
  (
    key: "test",
  ),
  (
    key: "test",
  ),
)

// https://forum.typst.app/t/why-does-tytanic-not-catch-panic-in-some-cases/4529/3
#context assert.eq(
  catch(() => _register-glossary(entry-list)),
  "panicked with: \"glossarium@" + glossarium_version + " error : key 'test' already exists in the glossary\"",
)
