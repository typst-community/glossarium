version := "0.4.0"
commit_hash := `git rev-parse --short HEAD`
benchmark_file := "tests/benchmark-" + commit_hash + ".md"
benchmark_commands := `find examples/**/*.typ -type f | xargs -I {} printf "'typst compile --root . {}' "`

# copy typst package to local registry
local:
    mkdir -p ~/.local/share/typst/packages/local/glossarium/{{version}}
    cp -r * ~/.local/share/typst/packages/local/glossarium/{{version}}

build-examples: 
    @find examples/**/*.typ -type f -exec sh -c "echo --------- Compiling {} && time typst compile --root . {}" \;

# format typst code (use typstfmt)
fmt:
    find -name "**.typ" -exec typstfmt {} \;

# benchmark using hyperfine
benchmark:
    hyperfine --warmup 10 --prepare 'find examples/**/*.pdf -delete' --export-markdown {{benchmark_file}} {{benchmark_commands}}