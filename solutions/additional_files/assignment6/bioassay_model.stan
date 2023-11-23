data {
  int<lower = 0> N;
  array[N] int y;
  array[N] int n;
  vector[N] x;
  vector[2] mu;
  matrix[2,2] sigma;
}

parameters {
    vector[2] theta;  
}
model {
  theta ~ multi_normal(mu, sigma);
  for (i in 1:N) {
    y[i] ~ binomial_logit(n[i], theta[1] + theta[2]*x[i]);
  }
}