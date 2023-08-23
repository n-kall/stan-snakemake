data {
  int<lower=0> N;
  vector[N] Y;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  Y ~ student_t(3, mu, sigma);
}
