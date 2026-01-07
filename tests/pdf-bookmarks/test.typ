#import "../../themes/default.typ": *
#let entry-list = (
  (key: "foo"),
  (key: "bar"),
  (key: "baz"),
  (key: "qux"),
)
#register-glossary(entry-list)
#show: make-glossary

= Glossary

#print-glossary(entry-list, show-all: true)

= Heading 1: query @foo

= Heading 2: query @bar

#context {
  query(__glossarium_entry_selector).filter(f => f.body != [])
}

= Incorrect bookmark: figure with contextual body #figure(context [Ah])

= Correct bookmark: figure with contextual body but content caption: #figure(kind: "Bh", supplement: "", context [Bh], caption: [Bh])

#context {
  query(figure.where(kind: "Bh"))
}

= Correct bookmark: @foo[foo]

#context {
  (query(selector(heading).before(here())).at(-1),)
}

