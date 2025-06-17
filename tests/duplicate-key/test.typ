#import "../../themes/default.typ": *
#let entry-list = (
  (
    key: "test",
  ),
  (
    key: "test",
  ),
)
#register-glossary(entry-list)
#show: make-glossary

// https://forum.typst.app/t/why-does-tytanic-not-catch-panic-in-some-cases/4529/3
#context assert.eq(
  catch(() => _print-glossary(entry-list)),
  "panicked with: \"glossarium@" + glossarium_version + " error : key 'test' already exists in the glossary\"",
)
