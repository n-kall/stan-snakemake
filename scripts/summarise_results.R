library(vroom)
results <- snakemake@config[["results_path"]]

files <- list.files(results)

out <- vroom(paste0(results,files))

write.csv(out, paste0(results, "summary.csv"))
