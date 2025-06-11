# Build PDFs from my .typ (Typst) files

pdf:
	typst compile -f pdf slides.polylux.typ
	typst compile -f pdf slides.touying.typ

# Doesn't work for slides, as
# "error: page configuration is not allowed inside of containers"
# as in:
#   #set page(paper: "presentation-16-9")
html:
	typst compile --features html -f html slides.typ

diagram:
	d2 diagram.d2 diagram.png
