# Build PDFs from my .typ (Typst) files

.PHONY: pdf
pdf: slides

.PHONY: slides
slides:
	typst compile -f pdf slides.typ
	open slides.pdf

# Doesn't work for slides, as
# "error: page configuration is not allowed inside of containers"
# as in:
#   #set page(paper: "presentation-16-9")
.PHONY: html
html:
	typst compile --features html -f html slides.typ

.PHONY: diagram
diagram:
	d2 diagram.d2 diagram.png

.PHONY: clean
clean:
	rm slides.pdf

.PHONY: help
help:
	@echo "make pdf           alias for `make slides`"
	@echo "make slides        create slides.pdf from slides.typ"
	@echo "make diagram       experimental - create a diagram"
	@echo "make clean         delete slides.pdf"
	@echo "make help          gives this help text"
