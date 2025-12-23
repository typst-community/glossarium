#import "../../themes/default.typ": *
#let entry-list = (
  (
    key: "ram",
    short: "RAM",
    long: "Arbeitsspeicher",
    longplural: "Arbeitsspeicher",
    special: (
      genitiv: (
        short: "RAMs",
        long: "Arbeitsspeichers",
      ),
      dativ: (
        longplural: "Arbeitsspeichern",
      ),
    ),
  ),
)
#register-glossary(entry-list)
#show: make-glossary

Der #gls("ram", update: false)

Des #gls("ram", update: false, special: "genitiv")

Den #glspl("ram", update: false, special: "dativ")

#print-glossary(entry-list, show-all: true)
