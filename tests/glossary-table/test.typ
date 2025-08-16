#import "../../themes/default.typ": *
#import "@preview/unify:0.6.0": unit
#set page(margin: 0pt, height: auto)
#show link: set text(fill: rgb(160, 20, 40))
#show: make-glossary

#let entry-list = (
  // Physics Variables (Group A)
  (
    key: "g",
    short: $g$,
    long: "Gravitational Constant",
    description: unit("meter per second squared"),
    group: "Physics Variables",
  ),
  (
    key: "H",
    short: $H$,
    long: "Wave height",
    description: unit("meter"),
    group: "Physics Variables",
  ),
  (
    key: "D",
    short: $D$,
    long: "Water depth",
    description: unit("meter"),
    group: "Physics Variables",
  ),
  (
    key: "lambda",
    short: $λ$,
    long: "Wave length",
    description: unit("meter"),
    group: "Physics Variables",
  ),
  (
    key: "T",
    short: $T$,
    long: "Period",
    description: unit("second"),
    group: "Physics Variables",
  ),
  // SPH Variables (Group B)
  (
    key: "delta-p",
    short: $Δ p$,
    long: "Initial particle distance. Also denoted as Dp or dp",
    description: unit("meter"),
    group: "SPH Variables",
  ),
  (
    key: "hsmall",
    short: $h$,
    long: "Smoothing length",
    description: unit("meter"),
    group: "SPH Variables",
  ),
  (
    key: "c",
    short: $c$,
    long: "Speed of sound",
    description: unit("meter per second"),
    group: "SPH Variables",
  ),
  (
    key: "V",
    short: $V$,
    long: "Volume",
    description: unit("meter cubed"),
    group: "SPH Variables",
  ),
  (
    key: "rho",
    short: $ρ$,
    long: "Density",
    description: unit("kg/m^3"),
    group: "SPH Variables",
  ),
  (
    key: "p",
    short: $p$,
    long: "Pressure",
    description: unit("Pa"),
    group: "SPH Variables",
  ),
  (
    key: "m",
    short: $m$,
    long: "Mass",
    description: unit("kg"),
    group: "SPH Variables",
  ),
  (
    key: "u",
    short: $bold(u)$,
    long: "Velocity",
    description: unit("m/s"),
    group: "SPH Variables",
  ),
  (
    key: "x",
    short: $bold(x)$,
    long: "Position",
    description: unit("meter"),
    group: "SPH Variables",
  ),
  (
    key: "gamma",
    short: $Γ$,
    long: "Dissipation",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "omega",
    short: $Ω$,
    long: "Domain",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "domega-xi",
    short: $d Ω_x_i$,
    long: "Volume of particle i at position " + $bold(x)_i$,
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "omega-V",
    short: $∂Ω_V$,
    long: "Volume of support domain",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "omega-S",
    short: $∂Ω_S$,
    long: "Surface of support domain",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "W",
    short: $W$,
    long: "Smoothing Kernel",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "A",
    short: $A$,
    long: "Arbitrary property for SPH estimation",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "gamma-adiabatic",
    short: $γ$,
    long: "Adiabatic Index",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "Pi",
    short: $Π$,
    long: "Modeled Viscosity",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "epsilon",
    short: $ε$,
    long: "Numerical constant used in artificial viscosity to avoid dividing by zero",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "kappa",
    short: $κ$,
    long: "Scaling constant used to determine size of smoothing kernel radius",
    description: [],
    group: "SPH Variables",
  ),
  (
    key: "L2-norm",
    short: $||bold(x)_i - bold(x)_j||$,
    long: [L#super[2]-norm],
    description: [],
    group: "SPH Variables",
  ),
)

#register-glossary(entry-list)
// Your document

#print-glossary(
  show-all: false,
  deduplicate-back-references: true,
  description-separator: none,
  user-print-glossary: (entries, groups, ..kwargs) => {
    kwargs = kwargs.named()
    let user-print-gloss = kwargs.at("user-print-gloss")
    let show-all = kwargs.at("show-all")
    let minimum-refs = kwargs.at("minimum-refs")
    for kw in (
      // remove unused kwargs for user-print-gloss
      "group-heading-level",
      "group-sortkey",
      "entry-sortkey",
      "user-print-reference",
      "user-print-group-heading",
      "user-group-break",
      "user-print-gloss",
    ) {
      _ = kwargs.remove(kw)
    }
    grid(
      columns: 2,
      inset: 0% + 5pt, // use default inset
      stroke: 0pt,
      ..for group in groups {
        let group-entries = entries.filter(x => x.at(GROUP) == group)
        let group-ref-counts = group-entries.map(x => count-refs(x.at(KEY)))
        let print-group = (
          // ? group-heading-pagebreak Layout divergence if location is conditional on print-group
          group != "" and (show-all == true or group-ref-counts.any(x => x >= minimum-refs))
        )
        (
          // Group heading
          if print-group { grid.cell(group, colspan: 2) },
          ..for entry in entries.filter(x => x.group == group) {
            let display-entry = show-all == true or count-refs(entry.at(KEY)) >= minimum-refs
            // If the entry is not used, make row's total height 0%+0pt
            let inset = if display-entry { 0% + 5pt } else { 0% + 0pt }
            (
              grid.cell(inset: inset, {
                if display-entry {
                  entry.short
                }
              }),
              grid.cell(inset: inset, {
                [
                  // default-print-reference
                  #__glossarium_figure(
                    entry.at(KEY),
                    body: user-print-gloss(entry, ..kwargs),
                  )
                  // The line below adds a ref shorthand for plural form, e.g., "@term:pl"
                  #__glossarium_figure(entry.at(KEY) + ":pl")
                  // Same as above, but for capitalized form, e.g., "@Term"
                  // Skip if key is already capitalized
                  #if upper(entry.at(KEY).at(0)) != entry.at(KEY).at(0) {
                    [
                      #__glossarium_figure(
                        default-capitalize(entry.at(KEY)),
                      )
                      #__glossarium_figure(
                        default-capitalize(entry.at(KEY)) + ":pl",
                      )
                    ]
                  }
                ]
              }),
            )
          },
        )
      }
    )
  },
  user-print-gloss: (entry, ..kwargs) => {
    let show-all = kwargs.at("show-all")
    let minimum-refs = kwargs.at("minimum-refs")
    let user-print-back-references = kwargs.at("user-print-back-references")
    let deduplicate-back-references = kwargs.at("deduplicate-back-references")
    let display-entry = show-all == true or count-refs(entry.at(KEY)) >= minimum-refs
    if display-entry {
      emph(entry.long)
      box(width: 1fr, repeat[.])
      user-print-back-references(entry, deduplicate: deduplicate-back-references)
    }
  },
  entry-list,
)

#set page(width: auto, height: auto)
#for key in entry-list.map(x => x.key) {
  ref(label(key))
  pagebreak()
}
