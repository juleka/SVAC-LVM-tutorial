## Authors:      Ju
## Maintainers:  Ju, CJF
##
##
## ---------------------------------
## Purpose: plot LVM estimates for each model
## ---------------------------------

library(argparse)
library(RColorBrewer)
library(colorRamps)

## use this code if not working with a Makefile 
# setwd("~/git/SVAC-LVM-tutorial/")
# arguments <- list(input_static="estimate/output/SVAC_static_est.csv",
#                   input_dynamic="estimate/output/SVAC_dynamic_est.csv",
#                   logfile_static="visualize/output/log-plot-static-estimates.txt",
#                   logfile_dynamic="visualize/output/log-plot-dynamic-estimates.txt")

parser <- ArgumentParser()
parser$add_argument("--input_static", type="character")
parser$add_argument("--input_dynamic", type="character")
parser$add_argument("--logfile_static", type="character")
parser$add_argument("--logfile_dynamic", type="character")
arguments <- parser$parse_args()


make_plots_for_LVM_estimates <- function(type) {
  
  input_name  <- paste('input', type, sep='_')
  logfile_name <- paste('logfile', type, sep='_')
  
  sink(arguments[[logfile_name]])
  
  data <- read.csv(arguments[[input_name]], header = TRUE, sep='|', stringsAsFactors = FALSE)
  print(str(data))
  
  ## this time, we will plot our estimates for a few cases in which SV is reported most prevalent
  ## these are the 10 most badly ranked cases:
  worst_reported <- sort(unique(data$rank), decreasing=TRUE)[1:10]
  
  ## these are their conflict ids:
  reported_worst_conflicts <- unique(data[data$rank %in% worst_reported, 'conflictid_new'])
  
  print(paste("Unique conflicts to work on:", length(reported_worst_conflicts)))
  
  for (i in reported_worst_conflicts) {
    print(paste('Now working on', unique(data[data$conflictid_new==i, 'country']), i))
    
    pdata <- data[data$conflictid_new==i,]

    xmax <- max(pdata$year, na.rm = TRUE)
    xmin <- min(pdata$year, na.rm = TRUE)

    ymax <- round(max(pdata$state_prev, pdata$ai_prev, pdata$hrw_prev, pdata$theta_upper, na.rm = TRUE), digits = 0)
    ymin <- round(min(pdata$state_prev, pdata$ai_prev, pdata$hrw_prev, pdata$theta_low, na.rm = TRUE), digits = 0)
    
    country <- unique(pdata[pdata$conflictid_new==i, 'country'])
    country <- gsub('\\(', '', country)
    country <- gsub('\\)', '', country)
    country <- gsub(",", "", country)
    country <- gsub("'", "-", country)
    country <- gsub(' ', '-', country)
    
    outputfile_name <- paste('output/pp-', type, '-estimates-', country, '-', i, '.pdf', sep='')
    
    pdf(outputfile_name, width=15, height=6)
    par(las=1,  mar=c(4,4,1.5,12), xpd=TRUE)
    print('set plotting parameters')
    print(paste(unique(pdata$country),unique(pdata$conflictid_new)))
    
    ## first, we create an empty plot, we will fill it later
    plot(NULL, type="n", bty='n', xlab="", ylab="Prevalence", 
         xlim=c(xmin, xmax), ylim = c(ymin,ymax), xaxt='n', yaxt='n',
         main=paste(unique(pdata$country),unique(pdata$conflictid_new), 'Government'))

    axis(1, at = seq(xmin, xmax, by=1))
    axis(2, at = seq(ymin, ymax, by = 1))
    abline(h=0, lty=3)
    
    points(pdata$year, pdata$theta, col='black', pch=16)
    arrows(pdata$year, pdata$theta_low, pdata$year, pdata$theta_upper, length=0, angle=90, 
             col='black', lwd=2.5)
    
    # legend('topright', inset=c(-.25,0), 
    #        c(paste("observed", unique(pdata$actor)[1:length(unique(pdata$actor))]), 
    #          paste("estimated", unique(pdata$actor)[1:length(unique(pdata$actor))])),
    #        col='black',  pch=16,
    #        bty='n',  cex=1.5 #cex=.75#,
    # )
    dev.off()
  }
}

make_plots_for_LVM_estimates('static')
make_plots_for_LVM_estimates('dynamic')

#end.