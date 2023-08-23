library(vroom)
results <- snakemake@config[["results_path"]]

files <- list.files(results)

out <- vroom(paste0(results,files))

print(out)
