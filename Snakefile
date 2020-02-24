singularity: "docker://continuumio/miniconda3"

rule all:
    input:
        "results/pca.svg"

rule plot_test:
    output:
        "results/pca.svg"
    conda:
        "deseq2.yaml"
    script:
        "plot-test.R"
