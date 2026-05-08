// glossarium figure kind
#let __glossarium_entry = "glossarium_entry"
#let __glossarium_entry_selector = figure.where(kind: __glossarium_entry)

// prefix of label for references query
#let __glossary_label_prefix = "__gls:"

// global state containing the glossary entry and their location
// A glossary entry is a `dictionary`.
// See `__normalize_entry_list`.
#let __glossary_entries = state("__glossary_entries", (:))

// glossarium version
#let glossarium_version = "0.5.10"

// error prefix
#let __glossarium_error_prefix = (
  "glossarium@" + glossarium_version + " error : "
)


// Helper function to create a labeled glossarium figure
#let __glossarium_figure(label-key, body: []) = {
  if body == [] {
    return [#figure(
        kind: __glossarium_entry,
        supplement: "",
        numbering: none,
      )[]#label(label-key)]
  }
  return [#figure(
      kind: __glossarium_entry,
      supplement: "",
      numbering: none,
      body,
    )#label(label-key)]
}

// get-entry-back-references(entry) -> array<content>
// Get the back references of the entry
//
// # Arguments
// entry (dictionary): the entry
//
// # Returns
// The back references as an array of links
#let get-entry-back-references(entry, deduplicate: false) = {
  let term-references = __query_labels_with_key(entry.at(KEY))
  let back-references = term-references
    .map(x => x.location())
    .sorted(key: x => x.page())
  if deduplicate {
    back-references = back-references
      .fold((values: (), pages: ()), ((values, pages), x) => {
        if pages.contains(x.page()) {
          // Skip duplicate references
          return (values: values, pages: pages)
        } else {
          // Add the back reference
          values.push(x)
          pages.push(x.page())
          return (values: values, pages: pages)
        }
      })
      .values
  }
  return back-references.map(x => {
    let page-numbering = x.page-numbering()
    if page-numbering == none {
      page-numbering = "1"
    }
    return link(x)[#numbering(page-numbering, ..counter(page).at(x))]
  })
}
