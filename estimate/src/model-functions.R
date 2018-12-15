## Authors:      Ju
## Maintainers:  Ju
##
## --------------------------------------------------------------------
## Purpose: a selection of functions to be used with stan model objects
## --------------------------------------------------------------------

make_Rhat_plot <- function(stan_data_out, model_name) {
  
  ## stan_data_out: name of the data object that came straight out of stan
  ## model_name: 'static' or 'dynamic', depending on which model is being estimated
  
  output_file_name <- paste('output/gg-rhat-SVAC-', model_name, '.pdf', sep='')
  print(paste('plotting rhats to' , output_file_name))
  
  stan_rhat(stan_data_out, fill='grey', bins=30)
  ggsave(file=output_file_name, height=8, width=6)
}


plot_cutpoints_by_source <- function(extracted_fit, model_name) {
  
  ## extracted_fit: name of the object that was extracted from the stan object
  ## model_name: 'static' or 'dynamic', depending on which model is being estimated
  
  source_names <- c('ai', 'hrw', 'state')
  
  for (sname in source_names) { 
    
    print(paste('Now working on cutpoint plot for:', sname))
    
    c_vec   <- paste('c', sname, sep='_')
    
    cut_point_obj  <- data.frame(category=rep(1, length(extracted_fit[[c_vec]][,1])), 
                                 value= (extracted_fit[[c_vec]][,1] / 
                                           extracted_fit[['beta']][,1]))
    cut_point_obj  <- rbind(cut_point_obj, data.frame(category=rep(2, length(extracted_fit[[c_vec]][,2])), 
                                                      value=(extracted_fit[[c_vec]][,2] / 
                                                               extracted_fit[['beta']][,2])))
    cut_point_obj  <- rbind(cut_point_obj, data.frame(category=rep(3, length(extracted_fit[[c_vec]][,3])), 
                                                      value=(extracted_fit[[c_vec]][,3] / 
                                                               extracted_fit[['beta']][,3])))
    
    outputfilename <- paste('output/bp-cp-', model_name, '-', sname, '.pdf', sep='')
    
    print(paste('Plotting cut points to', outputfilename))
    pdf(outputfilename, height=8, width=8)
    par(las=1)
    boxplot(value~category, data=cut_point_obj, xlab='Category', ylab='Value')
    dev.off()
  }
}

## end of script.