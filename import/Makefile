# Makefile
#
# :Authors: 	Ju
# :Maintainers: Ju

# ============================================

.PHONY: all clean

all: \
		output/SVAC_main.csv

clean:
	rm -f output/*

output/SVAC_main.csv: \
		src/import-check-data-main.R \
		input/SVAC-gov-main.csv \
		Makefile
	Rscript --vanilla $< \
		--inputfile=input/SVAC-gov-main.csv \
		--outputfile=$@

#end.
