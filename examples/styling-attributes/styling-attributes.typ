#import "../../glossarium.typ": make-glossary, register-glossary, print-glossary, gls, glspl
// #import "@preview/glossarium:0.5.5": make-glossary, register-glossary, print-glossary, gls, glspl

#show: make-glossary
#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
  ),
  (
    key: "uclouvain",
    short: "UCLouvain",
    long: "Université catholique de Louvain",
  ),
)
#let entry-list = entry-list.map(e => {
  e.insert("short", smallcaps(e.short))
  return e
})
#register-glossary(entry-list)
#print-glossary(entry-list)

Kuleuven: @kuleuven

UCLouvain: @uclouvain
