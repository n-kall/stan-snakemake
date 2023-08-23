normal_dgp <- function(rep_id, n_obs, mu, sigma, ...) {

  dgp_args <- list(n_obs = n_obs, mu = mu, sigma = sigma)

  true_pars <- list(mu = mu, sigma = sigma)

  simy <- rnorm(n_obs, mu, sigma)

  return(
    list(
      rep_id = rep_id,
      data = list(Y = simy, N = length(simy)),
      dgp_args = dgp_args,
      true_pars = true_pars
    )
  )
}

dgp <- function(n_datasets) {
  set.seed(1994)

  datasets <- generate_from_dgp(
    dgp = normal_dgp,
    n_datasets = n_datasets,
    n_obs = 25,
    mu = 1,
    sigma = 5
  )
}
