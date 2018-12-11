## Authors:      CJF, Ju
## Maintainers:  Ju
##
## ---------------------------------
## Purpose: estimate dynamic model
## ---------------------------------

library(argparse)
library(yaml)
library(rstan)

rm(list=ls())

parser    <- ArgumentParser()
parser$add_argument("--inputfile", type='character')
parser$add_argument("--STANcode", type='character')
parser$add_argument("--CONSTANTS", type='character')
parser$add_argument("--model_functions", type='character')
parser$add_argument("--outputfile", type='character')
arguments <- parser$parse_args()

## declare arguments if not working with Makefile
# setwd("~/git/SVAC-LVM-tutorial/")
# arguments <- list(inputfile='import/output/SVAC_main.csv',
#                   STANcode='estimate/src/SVAC_dynamic.stan',
#                   model_functions='estimate/src/model-functions.R',
#                   CONSTANTS='estimate/hand/CONSTANTS.yaml',
#                   outputfile='estimate/output/SVAC_dynamic_est.csv')


CONSTANTS <- yaml.load_file(arguments$CONSTANTS)
source(arguments$model_functions)

data <- read.csv(arguments$inputfile, sep="|", stringsAsFactors = FALSE)

## for the dynamic model, we create a panel-lag structure, 
##  so the model can account for the observed value of a given source in the previous year
panel_index_lag <- 0
for(ii in 2:nrow(data)){
  if(data$year[ii] - data$year[ii-1]==1){
    panel_index_lag[ii] <- panel_index_lag[ii-1] + 1
  }
  else{
    panel_index_lag[ii] <- 0
  }
}

print(panel_index_lag)

## state_prev ai_prev hrw_prev
state <- data$state_prev + 1
ai    <- data$ai_prev + 1
hrw   <- data$hrw_prev + 1

index_all   <- 1:nrow(data)
index_state <- index_all[!is.na(state)]
index_ai    <- index_all[!is.na(ai)]
index_hrw   <- index_all[!is.na(hrw)]

state <- state[!is.na(state)]
ai    <- ai[!is.na(ai)]
hrw   <- hrw[!is.na(hrw)]

n_state <- length(state)
n_ai    <- length(ai)
n_hrw   <- length(hrw)
n_all   <- nrow(data)

stan.data <- list(
  n_state = n_state,
  n_ai = n_ai,
  n_hrw = n_hrw,
  n_all = n_all,
  
  index_state = index_state,
  index_ai = index_ai,
  index_hrw = index_hrw,
  
  state = state,
  ai = ai,
  hrw = hrw,
  
  panel_index_lag = panel_index_lag
)

set.seed(CONSTANTS$random_seed)

dynamic.stan.fit <- stan(
  file=arguments$STANcode,
  data=stan.data,
  iter=CONSTANTS$dynamic_STAN_iter,
  chains=CONSTANTS$dynamic_STAN_chains,
  cores=CONSTANTS$dynamic_STAN_cores
)

## plot Rhats
make_Rhat_plot(dynamic.stan.fit, 'dynamic')

## extract the relevant model parameters: cut_points [the 'c_' variables], theta
dynamicstanout <- extract(dynamic.stan.fit)

## plot cutpoints
plot_cutpoints_by_source(dynamicstanout, 'dynamic')

data$theta       <- apply(dynamicstanout$theta, 2, mean)
data$theta_sd    <- apply(dynamicstanout$theta, 2, sd)
data$theta_upper <- apply(dynamicstanout$theta, 2, quantile, 0.975)
data$theta_low   <- apply(dynamicstanout$theta, 2, quantile, 0.025)

write.table(data, arguments$outputfile, sep='|', row.names = FALSE)
#end of Rscript.