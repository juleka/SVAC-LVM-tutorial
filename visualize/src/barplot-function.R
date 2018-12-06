## Authors:      Ju
## Maintainers:  Ju,
##
## ---------------------------------
## Purpose: a function to automate the generation of a select set of barplots
## ---------------------------------

barplot_observed_values <- function(id) {
  
  subdata <- data[data$conflictid_new==id,]
  
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

#end of script.