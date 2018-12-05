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
parser$add_argument("--logfile", type="character")
arguments <- parser$parse_args()

## use this code if not working with a Makefile
# setwd("~/git/SVAC-LVM-tutorial/")
# arguments <- list(inputfile="import/output/SVAC_main.csv",
#                   logfile="visualize/output/barplot-sources-by-conflict.txt")

# create a log file of this task 
sink(arguments$logfile)

data <- read.csv(arguments$inputfile, header=TRUE, sep='|', stringsAsFactors = FALSE)

#identify the prevalence vectors, i.e., our coding of the sexual violence reports
prev_vec <- c('ai_prev', 'hrw_prev', 'state_prev')
prev_colors <- c(rgb(1,0,0,.4), rgb(0,0,1,.4), rgb(1,1,0,.4))

barplot_observed_values <- function(id) {
  
  subdata <- data[data$conflictid_new==id,]
  
  #FIXME: add a test to require a minimum number of observations
  
  country.name <- unique(subdata$country)
  plot.caption <- unique(subdata$country_conflict_plot_caption)      
  
  ##clean up country names a bit to improve file names
  country.name <- gsub("\\(", "", country.name)
  country.name <- gsub("\\)", "", country.name)
  country.name <- gsub(",", "", country.name)
  country.name <- gsub("'", "-", country.name)
  country.name <- gsub(" ", "-", country.name)
        
  ## keep this version if working with Makefile
  outputfile.name <- paste('output/bp-obs-GOV-', country.name, '-', id, '.pdf', sep='')

  ## use this version if working WITHOUT Makefile
  # outputfile.name <- paste('visualize/output/bp-obs-GOV-', country.name, '-', id, '.pdf', sep='')
        
  pdf(outputfile.name, width=8, height=4)
  par(las=1, mar=c(4,4,1.5,5), xpd=TRUE)
  barplot(t(as.matrix(subdata[,c(prev_vec)])), beside=TRUE, space=c(0,2),
          names.arg = subdata$year, col=prev_colors, 
          ylab='Prevalence', xlab='', axes=FALSE, las=2, 
          main=plot.caption)
  axis(2, at=unique(sort(t(as.matrix(subdata[,c(prev_vec)])))))
  legend("topright", inset=c(-.15,0),
               legend = c('AI', 'HRW', 'USSD'), fill = prev_colors)
  dev.off()
  print(paste('Wrote graph to', outputfile.name))
}


for (id in unique(data$conflictid_new)) {
  barplot_observed_values(id)
}

print("FINISHED RUNNING src/barplot-sources-by-conflict.R")

## end of script.


