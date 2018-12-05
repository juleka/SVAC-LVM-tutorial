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
		Makefile
	Rscript --vanilla $< \
		--inputfile=../import/output/SVAC_main.csv \
		--logfile=$@

## end.
