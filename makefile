# This makefile is only here of compatibility purposes.
# I highly recommand to use the command laucher just (https://just.systems/man/en/).


version=0.2.6

build-examples:
	@echo THIS MAKE COMMAND IS NOT THE OFFICIAL WAY
	@echo TO BUILD THE EXAMPLES. PLEASE USE THE JUST 
	@echo RECIPES DEFINED IN THE justfile IN THIS REPO.
	@echo ""
	mkdir -p ~/.local/share/typst/packages/local/glossarium/${version}
	cp -r * ~/.local/share/typst/packages/local/glossarium/${version}
	find examples/* -type d -exec typst compile --root {} {}/main.typ \;