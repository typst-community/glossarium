#import "../../themes/default.typ": *
#show: make-glossary
#register-glossary(((key: "foo"),))
#print-glossary(((key: "foo"),), show-all: true)

// https://forum.typst.app/t/why-does-tytanic-not-catch-panic-in-some-cases/4529/3
#context assert.eq(
  catch(() => _print-glossary(((key: "bar"),), show-all: true)),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : key 'bar' is not registered in the glossary. Use `register-glossary(entry-list)`.\"",
)
