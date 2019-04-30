## Authors:      Ju
## Maintainers:  Ju
##
## --------------------------------------------------------------------
## Purpose: a selection of functions to be used with stan model objects
## --------------------------------------------------------------------

make_Rhat_plot <- function(stan_data_out, model_name) {
  
  ## stan_data_out: name of the data object that came straight out of stan
  ## model_name: 'static' or 'dynamic', depending on which model is being estimated
  
  ## code when using Makefile
  output_file_name <- paste('output/gg-rhat-SVAC-', model_name, '.pdf', sep='')

  ## code when not using Makefile
  # output_file_name <- paste('estimate/output/gg-rhat-SVAC-', model_name, '.pdf', sep='')
  
  print(paste('plotting rhats to' , output_file_name))
  
  ## the stan_rhat function is part of the rstan library
  stan_rhat(stan_data_out, fill='grey', bins=30)
  ggsave(file=output_file_name, height=8, width=6)
}


plot_cutpoints_by_source <- function(extracted_fit, model_name) {
  
  ## extracted_fit: name of the object that was extracted from the stan object
  ## model_name: 'static' or 'dynamic', depending on which model is being estimated
  
    source_names <- c('ai', 'hrw', 'state')
    prev_colors <- c(CONSTANTS$prev_colors[[1]], CONSTANTS$prev_colors[[2]], CONSTANTS$prev_colors[[3]])
  
  for (sname in source_names) { 
    
    print(paste('Now working on cutpoint plot for:', sname))
    
    c_vec   <- paste('c', sname, sep='_')
    
    cut_point_obj  <- data.frame(category=rep(1, length(extracted_fit[[c_vec]][,1])), 
                                 value= (extracted_fit[[c_vec]][,1] / 
                                           extracted_fit[['beta']][, which(source_names==sname)]))
    cut_point_obj  <- rbind(cut_point_obj, data.frame(category=rep(2, length(extracted_fit[[c_vec]][,2])), 
                                                      value=(extracted_fit[[c_vec]][,2] / 
                                                               extracted_fit[['beta']][, which(source_names==sname)])))
    cut_point_obj  <- rbind(cut_point_obj, data.frame(category=rep(3, length(extracted_fit[[c_vec]][,3])), 
                                                      value=(extracted_fit[[c_vec]][,3] / 
                                                               extracted_fit[['beta']][, which(source_names==sname)])))
    
    ## code when using Makefile
    outputfilename <- paste('output/bp-cp-', model_name, '-', sname, '.pdf', sep='')

    ## code when not using Makefile 
    # outputfilename <- paste('estimate/output/bp-cp-', model_name, '-', sname, '.pdf', sep='')
    
    print(paste('Plotting cut points to', outputfilename))
    pdf(outputfilename, height=8, width=8)
    par(las=1)
    boxplot(value~category, data=cut_point_obj, xlab='Cut-Point', ylab='Estimated Latent Prevalence',
            ylim = c(0,7),
            col=prev_colors[which(source_names==sname)])
    dev.off()
  }
}

## end of script.
