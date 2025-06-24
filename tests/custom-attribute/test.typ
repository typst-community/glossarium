#import "../../themes/default.typ": *

#let entry-list = (
  (
    key: "c",
    short: $c$,
    description: "Speed of light in vacuum",
    custom: (unit: "m s^-1", other: 1),
  ),
  (
    key: "a",
    description: "semi-major axis of the ellipse",
    custom: 6378137,
  ),
)

#register-glossary(entry-list)
#show: make-glossary

=== Dictionary test
- ctx: true
  - gls-custom: #gls-custom("c", ctx: true)
  - Type: #type(gls-custom("c", ctx: true))
- ctx: false
  - gls-custom: #context gls-custom("c", ctx: false)
  - member access: #context gls-custom("c", ctx: false).unit
  - Type: #context type(gls-custom("c", ctx: false))

=== Simple value test
- ctx: true
  - gls-custom: #gls-custom("a", ctx: true)
  - Type: #type(gls-custom("a", ctx: true))
- ctx: false
  - gls-custom: #context gls-custom("a", ctx: false)
  - Type: #context type(gls-custom("a", ctx: false))
