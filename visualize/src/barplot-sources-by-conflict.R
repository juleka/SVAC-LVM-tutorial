## Authors:      Ju
## Maintainers:  Ju,
##
## ---------------------------------
## Purpose: create bargraphs of three HR sources, by conflict
## ---------------------------------

## get arguments for working with Makefile
library(argparse)
parser <- ArgumentParser()
parser$add_argument("--inputfile", type="character")
parser$add_argument("--barplot_function", type="character")
parser$add_argument("--logfile", type="character")
arguments <- parser$parse_args()

## use this code if not working with a Makefile
# setwd("~/git/SVAC-LVM-tutorial/")
# arguments <- list(inputfile="import/output/SVAC_main.csv",
#                   barplot_function="visualize/src/barplot-function.R",
#                   logfile="visualize/output/barplot-sources-by-conflict.txt")

# create a log file of this task 
source(arguments$barplot_function)
sink(arguments$logfile)

data <- read.csv(arguments$inputfile, header=TRUE, sep='|', stringsAsFactors = FALSE)

#identify the prevalence vectors, i.e., our coding of the sexual violence reports
prev_vec <- c('ai_prev', 'hrw_prev', 'state_prev')
prev_colors <- c(rgb(1,0,0,.4), rgb(0,0,1,.4), rgb(1,1,0,.4))


for (id in unique(data$conflictid_new)) {
  barplot_observed_values(id)
}

print("FINISHED RUNNING src/barplot-sources-by-conflict.R")

## end of script.


