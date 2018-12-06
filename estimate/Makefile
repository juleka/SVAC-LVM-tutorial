# Makefile
#
# :Authors: 	Ju
# :Maintainers: Ju

# ============================================

.PHONY: all clean

all: \
		output/SVAC_static_est.csv

clean:
	rm -f output/*

output/SVAC_static_est.csv: \
		src/estimate-static-SVAC.R \
		../import/output/SVAC_main.csv \
		src/SVAC_static.stan \
		hand/CONSTANTS.yaml \
		Makefile
	Rscript --vanilla $< \
		--inputfile=../import/output/SVAC_main.csv \
		--STANcode=src/SVAC_static.stan \
		--CONSTANTS=hand/CONSTANTS.yaml \
		--outputfile=$@ \
		--outSTANfull=output/SVAC_static_full.rds

#end of Makefile
