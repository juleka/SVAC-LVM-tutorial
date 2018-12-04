## Authors:      Ju
## Maintainers:  Ju,
##
## ---------------------------------
## Purpose: create bargraphs of three HR sources, by conflict
## ---------------------------------

library(argparse)
parser <- ArgumentParser()
parser$add_argument("--inputfile", type="character")
parser$add_argument("--logfile", type="character")
arguments <- parser$parse_args()


## use this code if not working with Makefiles
# setwd("~/git/SVAC-LVM-tutorial/")
# arguments <- list(inputfile="import/output/SVAC_main.csv",
#                   logfile="visualize/output/barplot-sources-by-conflict.txt")

# create a log file of this task 
sink(arguments$logfile)

data <- read.csv(arguments$inputfile, header=TRUE, sep='|', stringsAsFactors = FALSE)

## end of script.


