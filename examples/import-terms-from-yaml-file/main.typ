// EXAMPLE MADE BY Philipp Jungkamp (https://github.com/PJungkamp) in issue: https://github.com/typst-community/glossarium/issues/15

// The glossary command here is modeled after the bibliography command and accepts similar arguments.

#import "../../glossarium.typ": *
// #import "@preview/glossarium:0.5.4": *
#let read-glossary-entries(file) = {
  let entries = yaml(file)

  assert(
    type(entries) == dictionary,
    message: "The glossary at `" + file + "` is not a dictionary",
  )

  for (k, v) in entries.pairs() {
    assert(
      type(v) == dictionary,
      message: "The glossary entry `"
        + k
        + "` in `"
        + file
        + "` is not a dictionary",
    )

    for key in v.keys() {
      assert(
        key in ("short", "long", "description", "group"),
        message: "Found unexpected key `"
          + key
          + "` in glossary entry `"
          + k
          + "` in `"
          + file
          + "`",
      )
    }

    assert(
      type(v.short) == str,
      message: "The short form of glossary entry `"
        + k
        + "` in `"
        + file
        + "` is not a string",
    )

    if "long" in v {
      assert(
        type(v.long) == str,
        message: "The long form of glossary entry `"
          + k
          + "` in `"
          + file
          + "` is not a string",
      )
    }

    if "description" in v {
      assert(
        type(v.description) == str,
        message: "The description of glossary entry `"
          + k
          + "` in `"
          + file
          + "` is not a string",
      )
    }

    if "group" in v {
      assert(
        type(v.group) == str,
        message: "The optional group of glossary entry `"
          + k
          + "` in `"
          + file
          + "` is not a string",
      )
    }
  }

  return entries
    .pairs()
    .map(((key, entry)) => (
      key: key,
      short: eval(entry.at("short", default: ""), mode: "markup"),
      long: eval(entry.at("long", default: ""), mode: "markup"),
      description: eval(entry.at("description", default: ""), mode: "markup"),
      group: entry.at("group", default: ""),
      // file: file,
    ))
}

#let read-glossary(files) = {
  let entries = ()

  if type(files) != array {
    files = (files,)
  }

  for file in files {
    let new = read-glossary-entries(file)

    for entry in new {
      let duplicate = entries.find(e => e.key == entry.key)
      if duplicate != none {
        panic(
          "Found duplicate key `"
            + entry.key
            + "` in files `"
            + entry.file
            + "` and `"
            + duplicate.file
            + "`",
        )
      }
    }

    entries += new
  }

  return entries
}

#set page(paper: "a5")

#show: make-glossary
#let entries = read-glossary("glossary.yml")
#register-glossary(entries)

= Test Document

Reference to @ntc \
Reference to @bor

= Glossary

#print-glossary(entries, show-all: false)
