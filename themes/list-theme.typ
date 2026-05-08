#import utils.typ: (
__glossarium_figure,
get-entry-back-references
)
// default-print-back-references(entry) -> content
// Print the back references of the entry
//
// # Arguments
// entry (dictionary): the entry
//
// # Returns
// Joined back references
#let default-print-back-references(entry, deduplicate: false) = {
  return get-entry-back-references(entry, deduplicate: deduplicate).join(", ")
}

// default-print-description(entry) -> content
// Print the description of the entry
//
// # Arguments
// entry (dictionary): the entry
//
// # Returns
// The description of the entry
#let default-print-description(entry) = entry.at(DESCRIPTION)

// default-print-title(entry) -> content
// Print the title of the entry
//
// # Arguments
// entry (dictionary): the entry
//
// # Returns
// The title of the entry
#let default-print-title(entry) = {
  let caption = []
  let txt = strong.with(delta: 200)

  if has-long(entry) and has-short(entry) {
    caption += txt(emph(entry.at(SHORT)) + [ -- ] + entry.at(LONG))
  } else if has-long(entry) {
    caption += txt(entry.at(LONG))
  } else {
    caption += txt(emph(entry.at(SHORT)))
  }
  return caption
}

// default-print-gloss(
//  entry,
//  show-all: false,
//  disable-back-references: false,
//  deduplicate-back-references: false,
//  minimum-refs: 1,
//  description-separator: ": ",
//  user-print-title: default-print-title,
//  user-print-description: default-print-description,
//  user-print-back-references: default-print-back-references,
// ) -> content
// Print the entry
//
// # Arguments
//  entry (dictionary): the entry
//  show-all (bool): show all entries
//  disable-back-references (bool): disable back references
//  minimum-refs (int): minimum number of references to show the entry
//  ...
//
// # Returns
//  The gloss content
#let default-print-gloss(
  entry,
  show-all: false,
  disable-back-references: false,
  deduplicate-back-references: false,
  minimum-refs: 1,
  description-separator: ": ",
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = {
  set par(
    hanging-indent: 1em,
    first-line-indent: 0em,
  )
  // ? references-in-description layout divergence
  if show-all == true or count-refs(entry.at(KEY)) >= minimum-refs {
    // Title
    user-print-title(entry)

    // Description
    if has-description(entry) {
      // Title - Description separator
      description-separator
      user-print-description(entry)
    }

    // Back references
    // Separate context window to separate BR's query
    context if disable-back-references != true {
      " "
      user-print-back-references(
        entry,
        deduplicate: deduplicate-back-references,
      )
    }
  }
}


// default-print-reference(
//  entry,
//  show-all: false,
//  disable-back-references: false,
//  deduplicate-back-references: false,
//  minimum-refs: 1,
//  description-separator: ": ",
//  user-print-gloss: default-print-gloss,
//  user-print-title: default-print-title,
//  user-print-description: default-print-description,
//  user-print-back-references: default-print-back-references,
// ) -> content
// Print the entry
//
// # Arguments
//  entry (dictionary): the entry
//  show-all (bool): show all entries
//  disable-back-references (bool): disable back references
//  minimum-refs (int): minimum number of references to show the entry
//  ..;
//
// # Returns
// A glossarium figure+labels
#let default-print-reference(
  entry,
  show-all: false,
  disable-back-references: false,
  deduplicate-back-references: false,
  minimum-refs: 1,
  description-separator: ": ",
  shorthands: default-shorthands,
  user-print-gloss: default-print-gloss,
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = {
  let body = []
  let key = entry.at(KEY)

  // Shorthands
  let shorthands-functions = (
    // Main figure with full gloss content (always generated)
    (entry, key) => (
      key,
      user-print-gloss(
        entry,
        show-all: show-all,
        disable-back-references: disable-back-references,
        deduplicate-back-references: deduplicate-back-references,
        minimum-refs: minimum-refs,
        description-separator: description-separator,
        user-print-title: user-print-title,
        user-print-description: user-print-description,
        user-print-back-references: user-print-back-references,
      ),
    ),
  )
  for shorthand in shorthands {
    if shorthand in __glossarium_shorthands {
      shorthands-functions.push(__glossarium_shorthand_functions.at(shorthand))
    } else {
      panic(__error_message(
        key,
        __shorthand_is_not_supported,
        shorthand: shorthand,
      ))
    }
  }

  // Generate shorthand figures based on shorthands parameter
  for fn in shorthands-functions {
    let res = fn(entry, key)
    if res != none {
      let (label-key, figure-body) = res
      body += __glossarium_figure(label-key, body: figure-body)
    }
  }

  return body
}

// default-group-break() -> content
// Default group break
#let default-group-break() = {
  return []
}

#let default-print-group-heading(group, level: none) = {
  if level == none {
    let previous-headings = query(selector(heading).before(here()))
    if previous-headings.len() != 0 {
      level = previous-headings.last().level + 1
    } else {
      level = 1
    }
  }
  heading(group, level: level, outlined: false)
}


// default-print-glossary(
//  entries,
//  groups,
//  show-all: false,
//  disable-back-references: false,
//  group-heading-level: none,
//  minimum-refs: 1,
//  description-separator: ": ",
//  group-sortkey: g => g,
//  entry-sortkey: e => e.at(SORT),
//  user-print-reference: default-print-reference
//  user-group-break: default-group-break,
//  user-print-gloss: default-print-gloss,
//  user-print-title: default-print-title,
//  user-print-description: default-print-description,
//  user-print-back-references: default-print-back-references,
// ) -> contextual content
// Default glossary print function
//
// # Arguments
//  entries (array<dictionary>): the list of entries
//  groups (array<str>): the list of groups
//  show-all (bool): show all entries
//  disable-back-references (bool): disable back references
//  deduplicate-back-references (bool): deduplicate back references
//  group-heading-level (int): force the level of the group heading
//  minimum-refs (int): minimum number of references to show the entry
//  ...
//
// # Warnings
// A strong warning is given not to override `user-print-reference` without
// careful consideration of `default-print-reference`'s original implementation.
// The package's behaviour may break in unexpected ways if not handled correctly.
//
// # Returns
// The glossary content
#let default-print-glossary(
  entries,
  groups,
  show-all: false,
  disable-back-references: false,
  deduplicate-back-references: false,
  group-heading-level: none,
  minimum-refs: 1,
  description-separator: ": ",
  group-sortkey: g => g,
  entry-sortkey: e => e.at(SORT),
  shorthands: default-shorthands,
  user-print-group-heading: default-print-group-heading,
  user-print-reference: default-print-reference,
  user-group-break: default-group-break,
  user-print-gloss: default-print-gloss,
  user-print-title: default-print-title,
  user-print-description: default-print-description,
  user-print-back-references: default-print-back-references,
) = {
  for group in groups.sorted(key: group-sortkey) {
    let group-entries = entries.filter(x => x.at(GROUP) == group)
    let group-ref-counts = group-entries.map(x => count-refs(x.at(KEY)))
    let print-group = (
      // ? group-heading-pagebreak Layout divergence if location is conditional on print-group
      group != ""
        and (show-all == true or group-ref-counts.any(x => x >= minimum-refs))
    )
    // Only print group name if any entries are referenced
    if print-group {
      user-print-group-heading(group, level: group-heading-level)
    }
    for entry in group-entries.sorted(key: entry-sortkey) {
      user-print-reference(
        entry,
        show-all: show-all,
        disable-back-references: disable-back-references,
        deduplicate-back-references: deduplicate-back-references,
        minimum-refs: minimum-refs,
        description-separator: description-separator,
        shorthands: shorthands,
        user-print-gloss: user-print-gloss,
        user-print-title: user-print-title,
        user-print-description: user-print-description,
        user-print-back-references: user-print-back-references,
      )
    }
    if print-group {
      user-group-break()
    }
  }
}
