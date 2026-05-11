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

// ! Modify the user print-glossary if default changes
#let default-shorthands = (
  "plural",
  "capitalize",
  "capitalize-plural",
  "short",
  "long",
)
// Attributes
#let KEY = "key"
#let SHORT = "short"
#let LONG = "long"
#let ART_SHORT = "artshort"
#let ART_LONG = "artlong"
#let PLURAL = "plural"
#let LONG_PLURAL = "longplural"
#let DESCRIPTION = "description"
#let GROUP = "group"
#let SORT = "sort"
#let STYLES = "styles"
#let CUSTOM = "custom"
#let ATTRIBUTES = (
  KEY,
  SHORT,
  LONG,
  ART_SHORT,
  ART_LONG,
  PLURAL,
  LONG_PLURAL,
  DESCRIPTION,
  GROUP,
  SORT,
  STYLES,
  CUSTOM,
)
#let default-capitalize(text) = {
  if text == none { return text }
  if type(text) == content {
    panic(__error_message(text, __capitalize_called_with_content_type))
  }
  return upper(text.first()) + text.slice(1)
}
#let __uncapitalize(text) = {
  return lower(text.first()) + text.slice(1)
}

#let __get_attribute(entry, attrname) = entry.at(attrname)
#let __has_attribute(entry, attrname) = {
  let attr = __get_attribute(entry, attrname)
  return attr != none and attr != "" and attr != []
}
#let has-short(entry) = __has_attribute(entry, SHORT)
#let has-long(entry) = __has_attribute(entry, LONG)
#let has-artshort(entry) = __has_attribute(entry, ART_SHORT)
#let has-artlong(entry) = __has_attribute(entry, ART_LONG)
#let has-plural(entry) = __has_attribute(entry, PLURAL)
#let has-longplural(entry) = __has_attribute(entry, LONG_PLURAL)
#let has-description(entry) = __has_attribute(entry, DESCRIPTION)
#let has-group(entry) = __has_attribute(entry, GROUP)
#let has-sort(entry) = __has_attribute(entry, SORT)
#let has-styles(entry) = __has_attribute(entry, STYLES)
#let has-custom(entry) = __has_attribute(entry, CUSTOM)





// Shorthands @key:pl
#let __glossarium_shorthands = (
  "plural",
  "capitalize",
  "capitalize-plural",
  SHORT,
  LONG,
  DESCRIPTION,
  LONG_PLURAL,
  CUSTOM,
)
#let __glossarium_shorthands_suffixes = (
  plural: ":pl",
  short: ":" + SHORT,
  long: ":" + LONG,
  description: ":" + DESCRIPTION,
  longplural: ":" + LONG_PLURAL,
  custom: ":" + CUSTOM,
)
// Define label generators as functions
#let __glossarium_shorthand_functions = (
  // Plural reference shorthand (@key:pl)
  plural: (entry, key) => (key + ":pl", []),
  // Capitalized form (@Key) - only if not already capitalized
  capitalize: (entry, key) => if upper(key.at(0)) != key.at(0) {
    (default-capitalize(key), [])
  },
  // Capitalized plural form (@Key:pl) - only if not already capitalized
  capitalize-plural: (entry, key) => if upper(key.at(0)) != key.at(0) {
    (default-capitalize(key) + ":pl", [])
  },
  // Short form reference (@key:short) - only if has short form
  short: (entry, key) => if has-short(entry) {
    (key + ":" + SHORT, [])
  },
  // Long form reference (@key:long) - only if has long form
  long: (entry, key) => if has-long(entry) {
    (key + ":" + LONG, [])
  },
  // Description reference (@key:description) - only if has description
  description: (entry, key) => if has-description(entry) {
    (key + ":" + DESCRIPTION, [])
  },
  // Long plural form reference (@key:longplural) - only if has long or long plural
  longplural: (entry, key) => if has-longplural(entry) {
    (key + ":" + LONG_PLURAL, [])
  },
)

// Helper function to create a labeled glossarium figure
#let __glossarium_figure(label-key, body: []) = {
  if body == [] {
    return [#figure(
        kind: __glossarium_entry,
        supplement: "",
        numbering: none,
        gap: 0em,
        outlined: false,
      )[]#label(label-key)]
  }
  return [#figure(
      kind: __glossarium_entry,
      supplement: "",
      numbering: none,
      gap: 0em,
      outlined: false,
      body,
    )#label(label-key)]
}
// __query_labels_with_key(loc, key) -> array<label>
// Query the labels with the key
//
// # Arguments
//  loc (location): the location of the reference
//  key (str): the key of the term
//
// # Returns
// The labels with the key
#let __query_labels_with_key(key) = {
  return query(selector(label(__glossary_label_prefix + key)))
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
      return link(x, numbering(page-numbering, ..counter(page).at(x)))
  })
}

// global state containing the entry counts
#let __glossary_counts = state("__glossary_counts", (:))
#let __glossary_reset_locations = state("__glossary_reset_locations", ())
#let __glossary_final_counts() = {
  __glossary_reset_locations
    .final()
    .fold(__glossary_counts.final(), (acc, loc) => {
      for (k, v) in __glossary_counts.at(loc).pairs() {
        acc.insert(k, acc.at(k, default: 0) + v)
      }
      return acc
    })
}
#let __update_count(key) = {
  __glossary_counts.update(x => {
    x.insert(key, x.at(key, default: 0) + 1)
    return x
  })
}
#let reset-counts(..keys) = {
  keys = keys.pos()
  if type(keys) != array {
    panic(__error_message(none, __keys_must_be_an_array))
  }
  for key in keys {
    if key not in __glossary_entries.get() {
      panic(__error_message(key, __key_not_registered))
    }
  }
  if keys == () {
    __glossary_counts.update((:))
  } else {
    // partial reset
    __glossary_counts.update(x => {
      for key in keys {
        let _ = x.remove(key, default: none)
      }
      return x
    })
  }
  let loc = here()
  __glossary_reset_locations.update(x => x + (loc,))
}


// count-refs(key) -> int
// Count the number of references to the entry in the document
//
// # Arguments
// entry (dictionary): the entry
//
// # Returns
// The number of references to the entry
//
// # Usage
// ```typ
// #context count-refs("potato")
// ```
#let count-refs(key) = {
  return __glossary_final_counts().at(key, default: 0)
}

