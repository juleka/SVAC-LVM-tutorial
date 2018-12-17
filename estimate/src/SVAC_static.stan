//stan code for static model

data {
  
    // converting numbers to integers
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
}

parameters {
  
    //beta is a real number, bounded between zero and infinity, 
    // there are three intercepts, because we have three variables (AI, HRW, and State)
    real<lower=0> beta[3];

    //this is a special type of object, technically a real number, preserving the 
    //  order of the underlying ordered logit
    //  set of ordered cut points that go into the ordered var
    //  it is a coincidence that there are 3 vars/items with 3 levels/thresholds here
    //  e.g., adding PTS we would have 4 vars, one of 5 levels
    //  c... stands for cutpoint here
    ordered[3] c_state;
    ordered[3] c_ai;
    ordered[3] c_hrw;

    //latent trait, there will be a value for every single n we have
    //in the static model, if a country has all missing values, there will just be the
    //   prior because actual value cannot be computed
    vector[n_all] theta_raw;
}

transformed parameters {
  
    //looping through all of our subscripts, monitoring theta to use for inference
    vector[n_all] theta;

    //for all observed units, we deterministically transform theta, taking vector draw
    //   theta goes into the models, not theta_raw
    //   theta==theta_raw
    for(ii in 1:n_all){
        theta[ii] = theta_raw[ii];
    }
}

model{

    //theta raw is a vector of normally distributed values
    theta_raw ~ normal(0, 1);

    //likelihood equations, trying to pick the best cutpoints for theta
    //   with each ordered logit 
    for(ii in 1:n_state){
        state[ii] ~ ordered_logistic(beta[1] * theta[index_state[ii]], c_state);
    }

    for(ii in 1:n_ai){
        ai[ii] ~ ordered_logistic(beta[2] * theta[index_ai[ii]], c_ai);
    }

    for(ii in 1:n_hrw){
        hrw[ii] ~ ordered_logistic(beta[3] * theta[index_hrw[ii]], c_hrw);
    }

    // parameter beta is normally distributed with mean 0 and standard deviation 3
    beta ~ normal(0, 3);
}
