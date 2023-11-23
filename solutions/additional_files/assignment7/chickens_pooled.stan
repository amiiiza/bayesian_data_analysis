data {
  int<lower=0> N_observations;
  int<lower=0> N_diets;
  array[N_observations] int diet_idx; // Pair observations to their diets.
  vector[N_observations] weight;
}

parameters {
  real mean_diet;
  real<lower=0> sd_diet;
}

model {
  mean_diet ~ normal(180, 22);
  sd_diet ~ exponential(0.02);

  for (obs in 1:N_observations) {
    weight[obs] ~ normal(mean_diet, sd_diet);
  }
}

generated quantities {
  real weight_pred = normal_rng(mean_diet, sd_diet);
  real mean_five = normal_rng(180, 22); 
}