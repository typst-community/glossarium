#import "../../themes/default.typ": *
#show: make-glossary
#set page(numbering: "1")
#lorem(25)

@key1:pl
#gls("key2")

#lorem(45)

#print-glossary(
  (
    // (
    //   key: "key",
    //   short: "111111",
    //   group: "vvv"
    // ),
    (
      key: "key2",
      short: "222222",
      // group: "vvv"
    ),

    (
      key: "key1",
      short: "111111",
      // group: "voila",
    ),
  ),
  show-all: true,
)
