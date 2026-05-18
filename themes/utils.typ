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
// Errors types
#let __key_not_found = "key_not_found"
#let __key_already_exists = "key_already_exists"
#let __key_capitalization_is_ambiguous = "key_capitalization_is_ambiguous"
#let __attribute_is_empty = "attribute_is_empty"
#let __glossary_is_empty = "glossary_is_empty"
#let __key_not_registered = "key_not_registered"
#let __entry_has_neither_short_nor_long = "entry_has_neither_short_nor_long"
#let __make_glossary_not_called = "make_glossary_not_called"
#let __capitalize_called_with_content_type = "capitalize_called_with_content_type"
#let __entry_has_unknown_keys = "entry_has_unknown_keys"
#let __entry_list_is_not_array = "entry_list_is_not_array"
#let __longplural_but_not_long = "longplural_but_not_long"
#let __style_is_not_a_function = "style_is_not_a_function"
#let __style_unsupported_attributes = "style_unsupported_attributes"
#let __style_unknown_attribute = "style_unknown_attribute"
#let __keys_must_be_an_array = "keys_must_be_an_array"
#let __groups_must_be_an_array_of_strings = "groups_must_be_an_array_of_strings"
#let __shorthand_is_not_supported = "shorthand_is_not_supported"
#let __unknown_first_style = "unknown_first_style"
#let __unknown_error = "unknown_error"

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



// __error_message(key, kind, ..kwargs) -> str
// Generate an error message
//
// # Arguments
//  key (str): the key of the term
//  kind (str): the kind of the error
//  kwargs (arguments): additional arguments
//
// # Returns
// The error message
#let __error_message(key, kind, ..kwargs) = {
  let msg = none
  let kwargs = kwargs.named() // convert arguments sink to dictionary

  // Generate the error message
  if kind == __key_not_found {
    msg = "key '" + key + "' not found"
  } else if kind == __key_already_exists {
    msg = "key '" + key + "' already exists in the glossary"
  } else if kind == __key_capitalization_is_ambiguous {
    msg = (
      "key '"
        + key
        + "' already exists in the glossary with different capitalization"
    )
  } else if kind == __attribute_is_empty {
    let attr = kwargs.at("attr")
    msg = "requested attribute " + attr + " is empty for key '" + key + "'"
  } else if kind == __glossary_is_empty {
    msg = "glossary is empty. Use `register-glossary(entry-list)` immediately after `make-glossary`."
  } else if kind == __key_not_registered {
    msg = (
      "key '"
        + key
        + "' is not registered in the glossary. Use `register-glossary(entry-list)`."
    )
  } else if kind == __entry_has_neither_short_nor_long {
    msg = "entry '" + key + "' has neither short nor long form"
  } else if kind == __make_glossary_not_called {
    msg = "make-glossary not called. Add `#show: make-glossary` at the beginning of the document."
  } else if kind == __capitalize_called_with_content_type {
    msg = (
      "Capitalization was requested for "
        + key
        + ", but short or long is of type content. Use a string instead."
    )
  } else if kind == __entry_has_unknown_keys {
    let keys = kwargs.at("keys")
    msg = "entry '" + key + "' has unknown keys: " + keys
  } else if kind == __entry_list_is_not_array {
    msg = "entry-list is not an array."
  } else if kind == __longplural_but_not_long {
    msg = (
      "'"
        + key
        + "' has a longplural attribute but no long attribute. Longplural will not be shown."
    )
  } else if kind == __style_is_not_a_function {
    msg = "style-entries: style is not a function. Use a function to style the entries."
  } else if kind == __style_unsupported_attributes {
    let attr = kwargs.at("attr")
    msg = (
      "style-entries: attribute '" + attr + "' is not supported for styling."
    )
    if attr == GROUP {
      msg += " Use `user-print-group-heading` in `print-glossary` to style groups."
    }
  } else if kind == __style_unknown_attribute {
    let attr = kwargs.at("attr")
    msg = "style-entries: unknown attribute '" + attr + "' for styling."
  } else if kind == __keys_must_be_an_array {
    msg = "keys must be an array."
  } else if kind == __groups_must_be_an_array_of_strings {
    msg = "groups must be an array of strings, e.g., (\"\",)"
  } else if kind == __shorthand_is_not_supported {
    msg = (
      "shorthand '"
        + kwargs.at("shorthand")
        + "' is not supported. Use one of "
        + __glossarium_shorthands.join(", ")
    )
  } else if kind == __unknown_first_style {
    let first-style = kwargs.at("first-style")
    msg = "entry '" + key + "' has an unknown first-style: " + first-style
  } else {
    msg = "unknown error"
  }

  // return the error message
  return __glossarium_error_prefix + msg
}


// ! Modify the user print-glossary if default changes
#let default-shorthands = (
  "plural",
  "capitalize",
  "capitalize-plural",
  "short",
  "long",
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

