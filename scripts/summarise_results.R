library(vroom)
results_path <- snakemake@config[["results_path"]]
summary_path <- snakemake@config[["summary_path"]]

files <- list.files(results_path, pattern = "*.csv")

out <- vroom(paste0(results_path, files))

write.csv(out, paste0(summary_path, "summary.csv"))
