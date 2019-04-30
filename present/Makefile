# Makefile
#
# :Authors: 	Ju
# :Maintainers: Ju

# ============================================

.PHONY: all clean

all: \
		output/SVAC-LVM-workshop-slides.pdf

output/SVAC-LVM-workshop-slides.pdf: \
		src/SVAC-LVM-workshop-slides.tex \
		hand/*.jpg \
		hand/*.jpeg \
		../estimate/output/bp-cp-dynamic*.pdf \
		Makefile
	pdflatex src/SVAC-LVM-workshop-slides.tex
	pdflatex src/SVAC-LVM-workshop-slides.tex
	mv SVAC-LVM-workshop-slides.pdf output/
	rm SVAC-LVM-workshop-slides*

#end of Makefile.
