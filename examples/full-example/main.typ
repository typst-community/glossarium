
// @typstyle off
#import "../../glossarium.typ": make-glossary, register-glossary, print-glossary, gls, glspl, agls, gls-key, gls-short, gls-artshort, gls-plural, gls-long, gls-artlong, gls-longplural, gls-description, gls-group
// #import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl, agls, gls-key, gls-short, gls-artshort, gls-plural, gls-long, gls-artlong, gls-longplural, gls-description, gls-group
#show: make-glossary
#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
    long: "Katholieke Universiteit Leuven",
    longplural: "Katholieke Universiteiten Leuven",
    description: [Fugiat do fugiat est minim ullamco est eu duis minim nisi
      tempor adipisicing do _sunt_. #gls("vub")],
    plural: "KU Leuvens",
    artshort: "the",
    artlong: "the",
  ),
  (
    key: "uclouvain",
    short: "UCLouvain",
    long: "Université catholique de Louvain",
    description: "Sunt pariatur deserunt irure dolore veniam voluptate cillum in. Officia nulla laborum nostrud mollit officia aliqua. Laborum tempor aute proident fugiat adipisicing qui laborum tempor ad officia. Nulla ipsum voluptate in proident laborum labore nulla culpa sunt deserunt sit ad aliqua culpa.",
  ),
  (
    key: "ughent",
    short: "UGent",
    long: "Universiteit Gent",
    description: "Labore officia commodo dolor sunt eu sunt excepteur enim nisi ex ad officia magna. Nostrud elit ullamco quis amet id eu. Cupidatat elit cupidatat ad nulla laboris irure elit.",
  ),
  (
    key: "vub",
    short: "VUB",
    long: "Vrije Universiteit Brussel",
    description: [Proident veniam non aliquip commodo sunt cupidatat. Enim est
      cupidatat occaecat elit et. Adipisicing irure id consequat ullamco non.
      Labore sunt tempor et mollit. #gls("kuleuven", first: true)],
  ),
  (
    key: "ulb",
    short: "ULB",
    long: "",
    description: "Magna do officia sit reprehenderit anim esse. Eu Lorem ullamco incididunt minim quis sit sunt id mollit sit amet cupidatat. Labore incididunt enim culpa ex magna veniam proident non sint dolor. Incididunt proident esse culpa nostrud tempor cupidatat culpa consectetur excepteur ipsum deserunt duis exercitation. Non consectetur dolore culpa laboris in quis. Cupidatat aliquip exercitation id elit ipsum amet enim nostrud elit reprehenderit velit. Irure labore pariatur non dolore non officia laborum quis deserunt adipisicing cillum incididunt.",
  ),
  (
    key: "umons",
    short: "UMons",
    long: "Université de Mons",
    description: "Aliquip incididunt elit aliquip eu fugiat sit consectetur officia veniam sunt labore consequat sint eu. Minim occaecat irure consequat sint non enim. Ea consectetur do occaecat aliqua exercitation exercitation consectetur Lorem pariatur officia nostrud. Consequat duis minim veniam laboris nulla anim esse fugiat. Ullamco aliquip irure adipisicing quis est laboris.",
  ),
  (
    key: "uliege",
    short: "ULiège",
    long: "Université de Liège",
    description: "Tempor deserunt commodo reprehenderit eiusmod enim. Ut ullamco deserunt in elit commodo ipsum nisi voluptate proident culpa. Sunt do mollit velit et et amet consectetur tempor proident Lorem. Eu officia amet do ea occaecat velit fugiat qui tempor sunt aute. Magna Lorem veniam duis ea eiusmod labore non anim labore irure culpa Lorem dolor officia. Laboris reprehenderit eiusmod nostrud duis excepteur nisi officia.",
  ),
  (
    key: "unamur",
    short: "UNamur",
    long: "Université de Namur",
  ),
  (
    key: "lod",
    short: "LOD",
    artshort: "an",
    long: "level of details",
    description: lorem(10),
  ),
  (
    key: "notused",
    short: "Not used",
    description: [This key is not cited anywhere, it won't be in the glossary
      unless the `show-all` argument is set to true],
  ),
)
#register-glossary(entry-list)

#set page(paper: "a5")

//I recommend setting a show rule for the links to that your reader understand that they can click on the references to go to the term in the glossary.
#show link: set text(fill: blue.darken(60%))

There are many Belgian universities, like @kuleuven and @ulb. When repeating
their names, they won't show as a long version: @kuleuven, @ulb. But we can
still force them to be long using the `gls` function: #gls(
  "kuleuven",
  first: true,
).

We can also force them to be short: #gls("kuleuven", first: false). Finally, we
can make them plural:
+ using the `suffix` parameter: #gls("kuleuven", suffix: "s"), or
+ using the additional `supplement` onto the `ref`: @kuleuven[s], or
+ the plural function `#glspl(key: "kuleuven")` #glspl("kuleuven"), or
+ call `@kuleuven:pl` @kuleuven:pl

It is also possible to use the proper article with `#agls("lod")`: "#agls("lod")
system", "#agls("lod") system".

You can also override the text shown by setting the `display` argument: #gls(
  "kuleuven",
  display: "whatever you want",
)

Attributes of an entry can be retrieved using the available functions:
- `gls-key("kuleuven")`: #gls-key("kuleuven")
- `gls-short("kuleuven")`: #gls-short("kuleuven")
- `gls-artshort("kuleuven")`: #gls-artshort("kuleuven")
- `gls-plural("kuleuven")`: #gls-plural("kuleuven")
- `gls-long("kuleuven")`: #gls-long("kuleuven")
- `gls-artlong("kuleuven")`: #gls-artlong("kuleuven")
- `gls-longplural("kuleuven")`: #gls-longplural("kuleuven")
- `gls-description("kuleuven")`: #gls-description("kuleuven")
- `gls-group("kuleuven")`: #gls-group("kuleuven")

#pagebreak()

Numbering is, of course, correct when referencing the glossary: @kuleuven, @ulb,
@ughent, @vub, @ulb, @umons, @uliege, @unamur. They are also sorted based on
where the page is in the document and not the textual representation.

#pagebreak()

Additionally, you can load data externally and pass it as a parameter to the
`glossary.with` function to load data from an external format.

#pagebreak()

= Glossary

#print-glossary(
  entry-list,
  // show all term even if they are not referenced, default to true
  show-all: true,
  // disable the back ref at the end of the descriptions
  disable-back-references: true,
)
