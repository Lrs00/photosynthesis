data {
  int<lower=0> N;                  // number of observations
  int<lower=1> J;                  // number of mutants
  int<lower=1> I;                  // number of plates
  int<lower=1, upper=J> mutant[N]; // mutant group for each observation
  int<lower=1, upper=I> plate[N];  // plate for each observation
  vector[N] y;                     // observed outcome
}

parameters {
  real mu;                         // global intercept
  vector[J] beta;                  // mutant effects (fixed)
  vector[I] gamma;                 // additive plate effects
  vector<lower=0>[I] sigma_plate;  // plate-specific residual std dev
}

model {
  // Priors
  mu ~ normal(0, 1);            
  beta ~ normal(0, 1);
  gamma ~ normal(0, 1);           
  sigma_plate ~ cauchy(0, 2.5);   

  // Likelihood
  for (n in 1:N)
    y[n] ~ normal(mu + beta[mutant[n]] + gamma[plate[n]], sigma_plate[plate[n]]);
}

