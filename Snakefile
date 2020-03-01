singularity: "docker://continuumio/miniconda3"

rule all:
    input:
       "results/pca.svg",
        "mtcars-plot.png",
        "python-plot.png"

rule plot_test:
    output:
        "results/pca.svg"
    conda:
        "deseq2.yaml"
    script:
        "plot-test.R"

rule plot_py:
    output:
        "python-plot.png"
    conda:
        "minimal.yaml"
    script:
        "python-test.py"

rule plot_mtcars:
    output:
        "mtcars-plot.png"
    conda:
        "minimal.yaml"
#        "deseq2.yaml"
    script:
        "mtcars-test.R"
