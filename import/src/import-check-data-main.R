## Authors:      Ju
## Maintainers:  Ju,
##
## ---------------------------------
## Purpose: import and check SVAC data
## ---------------------------------

## i personally prefer to work with Makefiles and arguments
## if this is what you want to try, keep this code uncommented
## if you rather not work with Makefile, comment the below argparse code and 
##   uncomment the setwd() and arguments commands below
library(argparse)
parser <- ArgumentParser()
parser$add_argument("--inputfile", type="character")
parser$add_argument("--outputfile", type="character")
arguments <- parser$parse_args()

## use below lines of code instead if you do not want to run Makefiles
## you will need to fill in the path on your machine where the SVAC-LVM folder is located
# setwd("<fill in your personal path>/SVAC-LVM-tutorial/")
# arguments <- list(inputfile='import/input/SVAC-gov-main.csv',
#                   outputfile='import/output/SVAC_main.csv')

## let's import our data
data <- read.csv(arguments$inputfile, header=TRUE, sep='|', stringsAsFactors = FALSE)
summary(data)

## lets test if we really only have observations (country-years) for the government
stopifnot(length(data$actor_type==1)==nrow(data))

## lets add a variable that we can use in plotting later
data$country_conflict_plot_caption <- paste(data$country, data$conflictid_new)

## lets create a rank, i.e., rank conflicts from highest to lowest reported SV prevalence
data$sum_prev <- rowSums(data[, c('ai_prev', 'hrw_prev', 'state_prev')], na.rm=TRUE)

conflict_prev <- aggregate(data$sum_prev, by=list(data$conflictid_new), sum)
colnames(conflict_prev) <- c('conflictid_new', 'conflict_prev')
conflict_prev <- conflict_prev[order(conflict_prev$conflict_prev),]
conflict_prev$rank <- rank(conflict_prev$conflict_prev)# could also use, ties.method = 'random')

data <- merge(data, conflict_prev, by='conflictid_new')
table(data$rank)

## delete no longer need auxiliary columns
data$sum_prev <- data$conflict_prev <- NULL

## saving the data to a csv file
write.table(data, file=arguments$outputfile, sep='|', row.names = FALSE)

##end of script.