# Makefile
#
# :Authors: 	Ju
# :Maintainers: Ju

# ============================================

.PHONY: all clean

all: \
		output/SVAC_static_est.csv \
		output/SVAC_dynamic_est.csv

clean:
	rm -f output/*

output/SVAC_static_est.csv: \
		src/estimate-static-SVAC.R \
		../import/output/SVAC_main.csv \
		src/SVAC_static.stan \
		src/model-functions.R \
		hand/CONSTANTS.yaml
	Rscript --vanilla $< \
		--inputfile=../import/output/SVAC_main.csv \
		--STANcode=src/SVAC_static.stan \
		--CONSTANTS=hand/CONSTANTS.yaml \
		--model_functions=src/model-functions.R \
		--outputfile=$@

output/SVAC_dynamic_est.csv: \
		src/estimate-dynamic-SVAC.R \
		../import/output/SVAC_main.csv \
		src/SVAC_dynamic.stan \
		src/model-functions.R \
		hand/CONSTANTS.yaml
	Rscript --vanilla $< \
		--inputfile=../import/output/SVAC_main.csv \
		--STANcode=src/SVAC_dynamic.stan \
		--CONSTANTS=hand/CONSTANTS.yaml \
		--model_functions=src/model-functions.R \
		--outputfile=$@
	rm Rplots.pdf

#end of Makefile
