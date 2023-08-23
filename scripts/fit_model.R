library(cmdstanr)
library(posterior)
library(readr)

dataset <- readRDS(snakemake@input[["dataset"]])
exe_file <- snakemake@input[["exe_file"]]
output_file <- snakemake@output[["fit_summary"]]
n_datasets <- snakemake@config[["n_datasets"]]

m <- cmdstan_model(exe_file = exe_file)

print(dataset[[1]]$data)

fit <- m$sample(data = dataset[[1]]$data)

drw_sum <- summarise_draws(fit$draws(), default_summary_measures())

drw_sum$model <- exe_file
drw_sum$rep_id <- 1

write_csv(drw_sum, output_file)

for (rep in 2:n_datasets) {
  m <- cmdstan_model(exe_file = exe_file)

  fit <- m$sample(data = dataset[[rep]]$data)

  drw_sum <- summarise_draws(fit$draws(), default_summary_measures())

  drw_sum$model <- exe_file
  drw_sum$rep_id <- rep

  write_csv(drw_sum, output_file, append = TRUE)
}
