version=0.2.5

local: ## copy typst package to local registry
	mkdir -p ~/.local/share/typst/packages/local/glossarium/${version}
	cp -r * ~/.local/share/typst/packages/local/glossarium/${version}

all: ## build example
	typst compile --root . example/example.typ 

watch: ## watch example
	typst watch --root .  example/example.typ 

fmt: ## format typst code
	find -name "**.typ" -exec typstfmt {} \;


.PHONY: help
help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
