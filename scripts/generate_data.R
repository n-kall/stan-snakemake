library(bayesflow)

args <- commandArgs(trailingOnly = TRUE)

n_datasets <- as.numeric(args[[1]])
dgp_script <- args[[2]]
output_file <- args[[3]]

source(paste0(dgp_script))

datasets <- dgp(n_datasets)

saveRDS(datasets, output_file)
