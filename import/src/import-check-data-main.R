## Authors:      Ju
## Maintainers:  Ju,
##
## ---------------------------------
## Purpose: import and check SVAC data
## ---------------------------------

library(argparse)

setwd("~/git/SVAC-LVM-tutorial/import/")
arguments <- list(input='input/SVAC-gov-main.csv', 
                  output='output/SVAC_main.csv')

data <- read.csv(arguments$input, header=TRUE, sep='|', stringsAsFactors = FALSE)

stopifnot(nrow(data[data$actor_type==1,])==nrow(data))

write.table(data, file=arguments$output, row.names = FALSE)

##end of script.