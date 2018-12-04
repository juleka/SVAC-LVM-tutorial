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
# setwd("~/git/SVAC-LVM-tutorial/import/")
# arguments <- list(input='inputfile/SVAC-gov-main.csv', 
#                   output='outputfile/SVAC_main.csv')

## let's import our data
data <- read.csv(arguments$inputfile, header=TRUE, sep='|', stringsAsFactors = FALSE)

# lets test if we really only have observations (country-years) for the government
stopifnot(length(data$actor_type==1)==nrow(data))

# lets add a variable that we can use in plotting later
data$country_conflict_plot_caption <- paste(data$country, data$conflictid_new)

## saving the data to a csv file
write.table(data, file=arguments$outputfile, row.names = FALSE)

##end of script.