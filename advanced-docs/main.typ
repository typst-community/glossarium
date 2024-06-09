#import "../glossarium.typ": *

#show: make-glossary
#set page(paper: "a4")
#set heading(numbering: "1.")
#show link: set text(fill: red)
#let typc(body) = raw(body, lang: "typc")
#let typc-block(body) = rect(width: 100%, fill: gray.lighten(80%))[#set text(size: 9pt);#body]
#let entry-list = (
  (
    key: "WHO",
    short: "WHO",
    long: "World Health Organization",
    description: lorem(5),
    group: "Organizations",
  ),
  (
    key: "WTO",
    short: "WTO",
    long: "World Trade Organization",
    description: lorem(5),
    group: "Organizations",
  ),
  (
    key: "IMF",
    short: "IMF",
    long: "International Monetary Fund",
    description: lorem(5),
  ),
  (
    key: "UN",
    short: "UN",
    long: "United Nations",
    description: lorem(5),
  ),
  (
    key: "EU",
    short: "EU",
    long: "European Union",
    description: lorem(5),
  ),
  (
    key: "USA",
    short: "USA",
    long: "United States of America",
    description: lorem(5),
    group: "Countries",
  ),
  (
    key: "UK",
    short: "UK",
    long: "United Kingdom",
    description: lorem(5),
    group: "Countries",
  ),
  (
    key: "UAE",
    short: "UAE",
    long: "United Arab Emirates",
    description: lorem(5),
    group: "Countries",
  ),
)
#let entries = __normalize_entry_list(entry-list)
#let groups = entries.map(x => x.at("group")).dedup()

#align(center, heading([`glossarium@`#glossarium_version], level: 1, numbering: none))\

#text(fill: red.darken(10%), size: 11pt, font: "Iosevka Extrabold Extended")[
This document outline how to change the default behaviour of `glossarium` by
implementing "user functions". It is recommended to keep the default implementation and not to change the default behaviour of the package. 

If you have a need that require to change the defaults, you are expected to be knowledgeable in writing complex typst code and to try to debug your issues first on you own. Be aware that helping regular users and fixing bugs will take priority over helping you debug your own implementation of `glossarium` internal functions.]

#outline(indent: 1em)

= Customization

This section shows how to change the default behaviour of `glossarium` by
implementing user functions. It is recommended to keep to the user available
interface and not to change the default behaviour of the package. If you have
any suggestions or need help, please open an issue on the
#link("https://github.com/ENIB-Community/glossarium")[GitHub repository].

There are effectively two requirements for a user to use `glossarium`:
+ Write a #typc("show: make-glossary") rule to transform all
  #typc("@key") and #typc("@key:pl") into #typc("#gls(key)") or
  #typc("#glspl(key)") 
+ Call #typc("print-glossary(entry-list)") somewhere in order to write all
  labels

The `glossarium` package provides a default behaviour to
#typc("print-glossary"). In ascending order, all implemented behaviours are:

+ #typc("default-print-back-references(entry) -> contextual content")
+ #typc("default-print-description(entry) -> content")
+ #typc("default-print-title(entry) -> content")
+ #typc("default-print-gloss(entry, ...) -> contextual content")
+ #typc("default-print-reference(entry, ...) -> contextual content")
+ #typc("default-print-glossary(entries, groups, ...) -> contextual content")

/ gloss: A *gloss* is a single entry in the glossary. It is composed of a
  *title*, a *description*, and a list of *back references*.

/ reference: A *reference* is the construct `glossarium` uses to manage the
  glossary. Internally, it is constructed using #typc("figure()") and #typc("label()").

/ glossary: A *glossary* is the list of all glosses. It is composed of a list of
  *entries* and a list of *groups*. The default *group* is #typc("\"\"").

Each of these functions can be replaced by a user-defined function with the same
signature. Then, the user can pass them directly to #typc("print-glossary()"),
e.g., 
#typc-block[
```typc
let my-print-description(entry) = {
  let ent-description = entry.at("description", default: "")
  return text.with(size: 9pt)[#ent-description]
}
print-glossary(entry-list, user-print-description: my-print-description)
```
]

Keep in mind that some options are available from the start:
- `show-all (bool)` : show all entries, even if they are not referenced in the document
- `disable-back-references (bool)`: do not show back references
- `user-group-break (function: () => content)`: a function to call between groups

== Default functions

The functions are listed in order of reverse call hierarchy: 
+ #typc("print-glossary(entry-list)")
  + #typc("default-print-glossary(entries, groups)")
    + #typc("default-print-reference(entry)")
      + #typc("default-print-gloss(entry)")
        + #typc("default-print-title(entry)") 
        + #typc("default-print-description(entry)") 
        + #typc("default-print-back-references(entry)")
    + #typc("default-group-break()")

#text.with(fill: red.darken(10%))([
  #emoji.warning Although #typc("default-print-reference") is available to the
  user, it is not recommended to modify this function.
])

The full signatures for #typc("default-print-gloss()"),
#typc("default-print-reference()"), and
#typc("default-print-glossary()") in the next sections.

=== Arguments

The functions take the following arguments:
+ #typc("entries"): the normalized entry list
+ #typc("groups"): the list of groups
+ #typc("entry"): an entry

This is one #typc("entry"):
#typc-block[
  #entries.first()
]

#typc("groups")
#typc-block[
  #groups
]

#typc("entries")
#typc-block[
  #entries.slice(0, 2)
]

=== #typc("default-print-back-references(entry)")

The default implementation is:

#typc-block[
```typc
#let default-print-back-references(entry) = {
  return get-entry-back-references(entry).join(", ")
}
```
]

Without going into details, assume that
#typc("get-entry-back-references(entry)") returns a list of back references. The
function simply joins them with a comma.

For example, for @WHO, the back references are:
#typc-block[#context get-entry-back-references(entries.first()).join(", ")]

The value of #typc("get-entry-back-references(entry)") is:
#typc-block[#context get-entry-back-references(entries.first())]
where #typc("dest") contains a #typc("location").

=== #typc("default-print-description(entry)") 

The default implementation is:

#typc-block[
```typc
#let default-print-description(entry) = {
  return entry.at("description")
} 
```
]

=== #typc("default-print-title(entry)") 

The default implementation is:

#typc-block[
```typc
#let default-print-title(entry) = {
  let caption = []
  let txt = text.with(weight: 600)
  
  if has-long(entry) {
    caption += txt(emph(entry.short) + [ -- ] + entry.long)
  } else {
    caption += txt(emph(entry.short))
  }
  return caption
} 
```
]

The function is fairly simple to understand:
- If the entry has a long description, it returns #typc("text.with(weight: 600)[emph(entry.short) -- entry.long]") 
- If the entry does not have a long description, it returns #typc("text.with(weight: 600)[emph(entry.short)]") 

=== #typc("default-print-gloss(entry)") <ssec:print-gloss>

The default implementation is
#typc-block[
```typc
#let default-print-gloss(
  entry,
  show-all: false,
  disable-back-references: false,
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = context {
  let caption = []
  
  if show-all == true or count-refs(entry) != 0 {
    // Title
    caption += user-print-title(entry)

    // Description
    if has-description(entry) {
      // Title - Description separator
      caption += ": "

      caption += user-print-description(entry)
    }

    // Back references
    if disable-back-references != true {
      caption += " "

      caption += user-print-back-references(entry)
    }
  }

  return caption
}
```
]

- #typc("default-print-gloss") is responsible for printing separators between
  the title, description, and back references.
- It also checks if the entry should be printed or not. If the entry is not
  referenced in the document, it will not be printed unless #typc("show-all:
  true").
- If back references are disabled (#typc("disable-back-references: true")), they
  will not be printed.

The default behaviour will be displayed as such:
#typc-block[
  #default-print-gloss(entries.first())
]

Without back references:
#typc-block[
  #default-print-gloss(entries.first(), disable-back-references: true)
]

For a non-referenced entry:
#typc-block[
  show-all: false => #default-print-gloss(entries.at(1))

  show-all: true => #default-print-gloss(entries.at(2), show-all: true)
]

One important utility function is #typc("count-refs"). For @WHO, 
#typc("#context count-refs(entry)") is
#typc-block[
  #context count-refs(entries.first())
]

=== #typc("default-print-reference(entry)") <ssec:print-reference>

#text.with(fill: red.darken(10%))([
  #emoji.warning There are few reasons to modify this function. It is recommended
  to keep the default behaviour, but an override option is provided for advanced
  users.
])

The default implementation is:
#typc-block[
```typc
#let default-print-reference(
  entry,
  show-all: false,
  disable-back-references: false,
  user-print-gloss: default-print-gloss,
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = {
  return [
    #show figure.where(kind: __glossarium_figure): it => it.caption
    #par(
      hanging-indent: 1em,
      first-line-indent: 0em,
    )[
      #figure(
        supplement: "",
        kind: __glossarium_figure,
        numbering: none,
        caption: user-print-gloss(
          entry, 
          show-all: show-all, 
          disable-back-references: disable-back-references,
          user-print-title: user-print-title,
          user-print-description: user-print-description,
          user-print-back-references: user-print-back-references,
        ),
      )[] #label(entry.key)
      // Line below can be removed safely
      #figure(kind: __glossarium_figure, supplement: "")[] #label(entry.key + ":pl")
    ]
    #parbreak()
  ]
}
```
]

The function is responsible for creating the referenceable element and the label
for the gloss.  
- it uses #typc("figure()") and #typc("label()") to create the element and make
  it referenceable. #typc("glossarium") uses #typc("kind: __glossarium_figure")
  to uniquely identify glossary figures
- the figure's caption is the result of #typc("user-print-gloss()") (see
  previous section @ssec:print-gloss)
- By default, an additional empty figure with label #typc("key:pl")
  is created. This is useful for referencing plural forms of the glossary entry,
  e.g., #typc("@WHO:pl")=@WHO:pl. It can be safely removed.

#text.with(fill: red.darken(10%))([
  #emoji.warning Notice that #typc("entry.key") is used as the label. This usage
  implies that glosses with duplicate keys will not work, as labels must be
  unique.
])

The code below panics:
#typc-block[
  ```typc
  #figure(caption: "test")[]#label("a")
  #figure(caption: "test")[]#label("a")
  @a
  ```
]
with error
#typc-block[
  ```shell
  error: label `<a>` occurs multiple times in the document
  ```
]

=== #typc("default-print-glossary(entries, groups)")

#typc-block[
```typc
#let default-print-glossary(
  entries,
  groups,
  show-all: false,
  disable-back-references: false,
  user-print-reference: default-print-reference,
  user-group-break: default-group-break,
  user-print-gloss: default-print-gloss,
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = {
  let body = []
  let previous-heading = query(selector(heading).before(here())).last()
  
  for group in groups.sorted() {
    let group-entries = entries.filter(x => x.at("group") == group)
    let group-ref-counts = group-entries.map(count-refs)
    let print-group = (
      group != "" 
      and (
        show-all == true 
        or group-ref-counts.any(x => x > 0)
      )
    )

    // Only print group name if any entries are referenced
    if print-group { 
      body += [#heading(group, level: previous-heading.level + 1)] 
    }
    for entry in group-entries.sorted(key: x => x.key) {
      body += user-print-reference(
        entry, 
        show-all: show-all, 
        disable-back-references: disable-back-references,
        user-print-gloss: user-print-gloss,
        user-print-title: user-print-title,
        user-print-description: user-print-description,
        user-print-back-references: user-print-back-references,
      )
    }
    
    body += user-group-break()
  }

  return body
}
```
]

The function is responsible for printing the glossary. It iterates over all
groups and prints the entries. It also checks if the group should be printed or
not. If the group is empty, it will not be printed unless #typc("show-all:
true").

See the default style in @sssec:default-style.

== Styles

=== Default glossary <sssec:default-style>
  
// let parent-heading = query(heading(1)).first()

#typc-block[
= Glossary
#print-glossary(
  entry-list,
  show-all: true,
)
]
