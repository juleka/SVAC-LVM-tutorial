# Makefile
#
# :Authors: 	Ju
# :Maintainers: Ju

# ============================================

.PHONY: all clean

all: \
		output/barplot-sources-by-conflict.txt \
		output/log-plot-static-estimates.txt

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

output/log-plot-static-estimates.txt: \
		src/plot-LVM-estimates-by-conflict.R \
		../estimate/output/SVAC_static_est.csv \
		../estimate/output/SVAC_dynamic_est.csv \
		Makefile
	Rscript --vanilla $< \
		--input_static=../estimate/output/SVAC_static_est.csv \
		--input_dynamic=../estimate/output/SVAC_dynamic_est.csv \
		--logfile_static=$@ \
		--logfile_dynamic=output/log-plot-dynamic-estimates.txt
	rm Rplots.pdf
## end.
