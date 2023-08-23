library(cmdstanr)

stanfile <- snakemake@input[[1]]
binaryfile <- snakemake@output[[1]]

print(paste("compiling", stanfile))

m <- cmdstan_model(stan_file = stanfile, exe_file = binaryfile)
