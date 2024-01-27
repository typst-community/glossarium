version := "0.2.6"


# copy typst package to local registry
local:
	mkdir -p ~/.local/share/typst/packages/local/glossarium/{{version}}
	cp -r * ~/.local/share/typst/packages/local/glossarium/{{version}}

build-examples: local
    find examples/* -type d -exec typst compile --root {} {}/main.typ \;

# format typst code (use typstfmt)
fmt:
	find -name "**.typ" -exec typstfmt {} \;