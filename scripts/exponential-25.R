exponential_dgp <- function(rep_id, n_obs, lambda, ...) {

  dgp_args <- list(n_obs = n_obs, lambda = lambda)

  true_pars <- list(lambda = lambda)

  simy <- rexp(n = n_obs, rate = lambda)

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
    dgp = exponential_dgp,
    n_datasets = n_datasets,
    n_obs = 25,
    lambda = 1
  )
}
