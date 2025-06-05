#import "../../themes/default.typ": *
#show: make-glossary
#register-glossary(((key: "foo"),))
#print-glossary(((key: "foo"),), show-all: true)
// #print-glossary(((key: "bar"),), show-all: true)
// can't catch panic :(
// similar issue as duplicate-key
