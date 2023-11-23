data {
  int<lower=0> N_observations;
  int<lower=0> N_diets;
  array[N_observations] int diet_idx; // Pair observations to their diets.
  vector[N_observations] weight;
}

parameters {
  vector[N_diets] mean_diet;
  vector<lower=0>[N_diets] sd_diet;
}

model {
  for (diet in 1:N_diets) {
    mean_diet[diet] ~ normal(180, 22);
    sd_diet[diet] ~ exponential(0.02);
  }

  for (obs in 1:N_observations) {
    weight[obs] ~ normal(mean_diet[diet_idx[obs]], sd_diet[diet_idx[obs]]);
  }
}

generated quantities {
  real weight_pred = normal_rng(mean_diet[4], sd_diet[4]);
  real mean_five = normal_rng(180, 22);
}