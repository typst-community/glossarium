version := "0.5.10"
typst := "typst"

# copy typst package to local registry
local:
    mkdir -p ~/.local/share/typst/packages/local/glossarium/{{version}}
    cp -r * ~/.local/share/typst/packages/local/glossarium/{{version}}

build-examples:
    find examples/**/*.typ -type f | xargs -I {} sh -c "echo ------ Compiling {} && time {{typst}} compile --root . {}"

# format typst code
fmt:
    typstyle format-all

# build advanced docs
docs:
    {{typst}} compile advanced-docs/main.typ --root .

version:
    {{typst}} --version
