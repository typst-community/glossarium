/* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/

#let glossary_label_prefix = "glossary:"
#let glossary_entries = state("glossary_entries", (:))

#let query_labels_with_key(loc, key, before: false) = {
  if before {
    query(
      selector(label(glossary_label_prefix + key)).before(loc, inclusive: false),
      loc,
    )
  } else {
    query(
      selector(label(glossary_label_prefix + key)),
      loc,
    )
  }
}

#let gls(key, suffix: none, long: auto) = {
  locate(
    loc => {
      let glossary_entries = glossary_entries.final(loc);
      if key in glossary_entries {
        let entry = glossary_entries.at(key)

        let gloss = query_labels_with_key(loc, key, before: true)

        let is_first = gloss == ();
        let entlong = entry.at("long", default: "")
        let textLink = if (is_first or long == true) and entlong != [] and entlong != "" {
          [ #entry.short#suffix (#emph(entlong))]
        } else {
          [#entry.short#suffix ]
        }

        [
        #link(label(entry.key))[#textLink]
        #label(glossary_label_prefix + entry.key)
        ]
      } else {
        text(fill: red, "Glossary entry not found: " + key)
      }
    },
  )
}

#let glspl(key) = {
  gls(key, suffix: "s")
}

#let make-glossary(body) = {
  show ref: r => {
    if r.element != none and r.element.func() == figure and r.element.kind == "glossarium_entry" {
      // call to the general citing function
      gls(str(r.target), suffix: r.citation.supplement)
    } else {
      r
    }
  }
  body
}

#let print-glossary(entries, body) = {
  glossary_entries.update(
    (x) => {
      for entry in entries {
        x.insert(
          entry.key,
          (
            key: entry.key,
            short: entry.short,
            long: entry.long,
          ),
        )
      }

      x
    },
  )

  for entry in entries.sorted(key: (x) => x.key) {
    [
    #show figure.where(kind: "glossarium_entry"): it => it.caption
    #par(
      hanging-indent: 1em,
    )[
      #figure(
        supplement: "",
        kind: "glossarium_entry",
        caption: {
          {
            set text(weight: 600)
            let long = entry.at("long", default: "")
            if long != "" and long != [] [
            #emph(entry.short) - #entry.long:
            ] else [
            #emph(entry.short):
            ]
          }
          entry.at("desc", default: "")
          locate(
            loc => {
              query_labels_with_key(loc, entry.key)
              .map((x) => x.location())
              .sorted(key: (x) => x.page())
              .fold(
                (values: (), pages: ()),
                ((values, pages), x) => if pages.contains(x.page()) {
                  (values: values, pages: pages)
                } else {
                  values.push(x)
                  pages.push(x.page())
                  (values: values, pages: pages)
                },
              )
              .values
              .map(
                (x) => link(
                  x,
                )[#numbering(x.page-numbering(), ..counter(page).at(x))],
              )
              .join(", ")
            },
          )
        },
      )[] #label(entry.key)
      ]
    #parbreak()
    ]
  }

  body
};

