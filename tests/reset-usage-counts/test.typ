#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo", long: "Long Foo"),
  (key: "bar", long: "Long Bar"),
  (key: "baz", long: "Long Baz"),
  (key: "qux", long: "Long Qux"),
)
#register-glossary(entry-list)
#set page(width: auto, height: auto)
#show: make-glossary

= Glossary

#print-glossary(entry-list)

= Full reset

Current/Total: #context __glossary_counts.get()#context __glossary_reset_locations.get()

@foo

@foo

Current/Total: #context __glossary_counts.get()#context __glossary_reset_locations.get()

*Reset*#context reset-counts()

Current/Total: #context __glossary_counts.get()#context __glossary_reset_locations.get()

= Partial reset

@foo

@bar

@qux

Current/Total: #context __glossary_counts.get()#context __glossary_reset_locations.get()

*Reset*#context reset-counts("foo", "qux")

*Reset*#context reset-counts("qux")

#context assert.eq(
  catch(() => reset-counts("")),
  "panicked with: \"glossarium@"
    + glossarium_version
    + " error : key '' is not registered in the glossary. Use `register-glossary(entry-list)`.\"",
)

Current/Total: #context __glossary_counts.get()#context __glossary_reset_locations.get()

= Divergence

*Reset*#context reset-counts()
*Reset*#context reset-counts()
*Reset*#context reset-counts()
*Reset*#context reset-counts()

@Bar

#context __glossary_final_counts()

