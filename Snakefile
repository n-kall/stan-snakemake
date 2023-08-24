configfile: "config.yaml"

def get_stan_files(wildcards):
    return config["stanfile_path"] + wildcards.model + ".stan"

def get_compiled_models(wildcards):
    return config["compiled_path"] + wildcards.fit

def get_dataset(wildcards):
    return config["datasets_path"] + wildcards.dataset + ".RDS"

def get_fit_names(wildcards):
    return config["results"] + wildcards.fit + wildcards.dataset

def get_dgp_script(wildcards):
    return config["scripts_path"] + wildcards.dataset + ".R"

rule compile_all:
    input: expand(config["compiled_path"] + "{model}", model=config["models"])

rule compile:
    resources:
        runtime=10,
        cpus=1,
        mem_per_cpu=1000
    input:
        get_stan_files
    output:
        config["compiled_path"] + "{model}"
    script:
        config["scripts_path"] + config["scripts"]["compile"]

rule generate_data_all:
    input: expand(config["datasets_path"] + "{dataset}.RDS", dataset=config["datasets"])
        
rule generate_data:
    resources:
        runtime=10,
        cpus=1,
        mem_per_cpu=1000
    output:
        dataset_file=config["datasets_path"] + "{dataset}.RDS"
    params:
        n_datasets=config["n_datasets"],
        script=config["scripts_path"] + config["scripts"]["generate_data"],
        dgp=get_dgp_script
    shell:
        "Rscript '{params.script}' '{params.n_datasets}' '{params.dgp}' '{output.dataset_file}'"

        

rule fit_all:
    input: expand(config["results_path"] + "{fit}_{dataset}.csv", fit=config["models"], dataset=config["datasets"])
        
rule fit:
    resources:
        runtime=10,
        cpus=4,
        mem_per_cpu=1000
    input:
        dataset=get_dataset,
        exe_file=get_compiled_models
    output:
        fit_summary=config["results_path"] + "{fit}_{dataset}.csv"
    script:
        config["scripts_path"] + config["scripts"]["fit"]


rule summarise_all:
    resources:
        runtime=10,
        cpus=1,
        mem_per_cpu=1000
    input: expand(config["results_path"] + "{fit}_{dataset}.csv", fit=config["models"], dataset=config["datasets"])
    output:
        summary=config["results_path"] + "summary.csv"
    script:
        config["scripts_path"] + config["scripts"]["summarise"]
