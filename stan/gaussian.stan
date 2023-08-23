data {
  int<lower=0> N;
  vector[N] Y;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  Y ~ normal(mu, sigma);
}
