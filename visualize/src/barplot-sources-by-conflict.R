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

## lets plot a few cases for which SV prevalence is reported most
## these are the 10 most badly ranked cases:
worst_reported <- sort(unique(data$rank), decreasing=TRUE)[1:10]

## this is how we make a bargraph for the worst reported case
par(las=1, mar=c(4,4,1.5,0), xpd=TRUE)
barplot(t(as.matrix(data[data$rank==worst_reported[1], c(prev_vec)])), beside=TRUE, space=c(0,2),
        names.arg = data[data$rank==worst_reported[1], 'year'], col=prev_colors, 
        ylab='Prevalence', xlab='', axes=FALSE, las=2, 
        main=unique(data[data$rank==worst_reported[1], 'country_conflict_plot_caption']))
axis(2, at=unique(sort(t(as.matrix(data[,c(prev_vec)])))))
legend("topleft", bty='n',
       legend = c('AI', 'HRW', 'USSD'), fill = prev_colors)
dev.off()

## this is how we make a bargraph for the second worst reported case
par(las=1, mar=c(4,4,1.5,0), xpd=TRUE)
barplot(t(as.matrix(data[data$rank==worst_reported[2], c(prev_vec)])), beside=TRUE, space=c(0,2),
        names.arg = data[data$rank==worst_reported[2], 'year'], col=prev_colors, 
        ylab='Prevalence', xlab='', axes=FALSE, las=2, 
        main=unique(data[data$rank==worst_reported[2], 'country_conflict_plot_caption']))
axis(2, at=unique(sort(t(as.matrix(data[,c(prev_vec)])))))
legend("topleft", bty='n',
       legend = c('AI', 'HRW', 'USSD'), fill = prev_colors)
dev.off()

## you can manually create as many bargraphs as you like
## save them with the pdf function, see src/barplot-function.R for an example

## lets get the conflict_ids for the worst reported cases, because two conflicts are ranked 158.5
reported_worst_conflicts <- unique(data[data$rank %in% worst_reported, 'conflictid_new'])

## lets automatically create barplots for the 10 worst reported cases
for (id in reported_worst_conflicts) {
  barplot_observed_values(id)
}

print("FINISHED RUNNING src/barplot-sources-by-conflict.R")

## end of script.