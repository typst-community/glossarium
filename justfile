version := "0.5.6"
commit_hash := `git rev-parse --short HEAD`
benchmark_file := "tests/benchmark-" + commit_hash + ".md"
benchmark_commands := `find examples/**/*.typ -type f | xargs -I {} printf "'typst compile --root . {}' "`
typst := "typst"

# copy typst package to local registry
local:
    mkdir -p ~/.local/share/typst/packages/local/glossarium/{{version}}
    cp -r * ~/.local/share/typst/packages/local/glossarium/{{version}}

build-examples:
    find examples/**/*.typ -type f | xargs -I {} sh -c "echo ------ Compiling {} && time {{typst}} compile --root . {}"

test:
    find tests/**/*.typ -type f | xargs -I {} sh -c "echo ------ Compiling {} && {{typst}} compile --root . {}"

write-test name:
    mkdir -p tests/{{name}}
    echo '#import "../../themes/default.typ": *' > tests/{{name}}/{{name}}.typ

# format typst code
fmt:
    typstyle format-all

# benchmark using hyperfine
benchmark:
    hyperfine --warmup 10 --prepare 'find examples/**/*.pdf -delete' --export-markdown {{benchmark_file}} {{benchmark_commands}}

# build advanced docs
docs:
    {{typst}} compile advanced-docs/main.typ --root .

version:
    {{typst}} --version
