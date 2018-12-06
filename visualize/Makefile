# Makefile
#
# :Authors: 	Ju
# :Maintainers: Ju

# ============================================

.PHONY: all clean

all: \
		output/barplot-sources-by-conflict.txt

clean:
	rm -f output/*

output/barplot-sources-by-conflict.txt: \
		src/barplot-sources-by-conflict.R \
		../import/output/SVAC_main.csv \
		src/barplot-function.R \
		Makefile
	Rscript --vanilla $< \
		--inputfile=../import/output/SVAC_main.csv \
		--barplot_function=src/barplot-function.R \
		--logfile=$@

## end.
