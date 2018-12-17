//stan code for dynamic model

data {

    int n_state;
    int state[n_state];
    int index_state[n_state];

    int n_ai;
    int ai[n_ai];
    int index_ai[n_ai];

    int n_hrw;
    int hrw[n_hrw];
    int index_hrw[n_hrw];

    int n_all;

    int panel_index_lag[n_all];

}

parameters {
    real<lower=0> sigma;
    real<lower=0> beta[3];

    ordered[3] c_state;
    ordered[3] c_ai;
    ordered[3] c_hrw;

    vector[n_all] theta_raw;
}


transformed parameters {
    vector[n_all] theta;

    // making theta dynamic here by indexing the panel lags for theta, 
    //   multiplying by standard deviation sigma
    for(ii in 1:n_all){
        if(panel_index_lag[ii]==0){
            theta[ii] = theta_raw[ii];
        } else {
            theta[ii] = theta[panel_index_lag[ii]] + theta_raw[ii] * sigma;
    }

}

}

model{

    theta_raw ~ normal(0, 1);

    // sigmal also gets estimated, it is distributed normal
    sigma ~ normal(0, 1);


    for(ii in 1:n_state){
        state[ii] ~ ordered_logistic(beta[1] * theta[index_state[ii]], c_state);
    }

    for(ii in 1:n_ai){
        ai[ii] ~ ordered_logistic(beta[2] * theta[index_ai[ii]], c_ai);
    }

    for(ii in 1:n_hrw){
        hrw[ii] ~ ordered_logistic(beta[3] * theta[index_hrw[ii]], c_hrw);
    }

    beta ~ normal(0, 3);
}