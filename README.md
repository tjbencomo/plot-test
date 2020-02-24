# plot-test
This pipeline creates a PCA plot of RNASeq data from Kenny PJ et al. 
It's goal is to test how R draws a figures. I'm currently
encountering an error where the text is replaced by empty rectangles.

To replicate the rectangle drawing error, run the pipeline with conda and singularity:
```
snakemake --use-conda --use-singularity
```
In my own testing, this causes the PCA plot (found in `results/`) to be incorrectly
drawn. Running the pipeline without the singularity container 
```
snakemake --use-conda
```
remedies the issue, suggesting the issue is with singularity.
My guess is that the singularity linux distribution is lacking the needed
drawing library to correctly handle text
