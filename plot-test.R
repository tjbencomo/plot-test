library(DESeq2)
library(tximport)
library(magrittr)
library(stringr)

## List all directories containing data  
samples <- list.files(path = "./data", full.names = T, pattern="salmon$")

## Obtain a vector of all filenames including the path
files <- file.path(samples, "quant.sf")

## Since all quant files have the same name it is useful to have names for each element
names(files) <- str_replace(samples, "./data/", "") %>% 
                str_replace(".salmon", "")

# Load the annotation table for GrCh38
tx2gene <- read.delim("tx2gene_grch38_ens94.txt")
txi <- tximport(files, type="salmon", tx2gene=tx2gene[,c("tx_id", "ensgene")], countsFromAbundance="lengthScaledTPM")

sampletype <- factor(c(rep("control",3), rep("MOV10_knockdown", 2), rep("MOV10_overexpression", 3)))
meta <- data.frame(sampletype, row.names = colnames(txi$counts))
dds <- DESeqDataSetFromTximport(txi, colData = meta, design = ~ sampletype)
dds <- estimateSizeFactors(dds)
normalized_counts <- counts(dds, normalized=TRUE)
rld <- rlog(dds, blind=T)
svg("results/pca.svg")
plotPCA(rld, intgroup="sampletype")
dev.off()
print(warnings())
