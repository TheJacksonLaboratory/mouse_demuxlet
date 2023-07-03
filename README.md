# Single cell genetic demultiplexing in the mouse

In this repository we show
how to carry out genetic demultiplexing of pooled mouse 
single cell/nucleus transcriptomics
data. We use the software `demuxlet`
([Kang et al. 2018](https://pubmed.ncbi.nlm.nih.gov/29227470/)) which
can be found at [this link](https://github.com/statgen/popscle).
These methods should also work for single nucleus ATAC-Seq as well (see 
[this link](https://github.com/statgen/popscle/blob/master/tutorials/README_atac.md)).

Below, we show how to run `demuxlet` in the case where you have 
heterozygous (possibly outbred) mice, such as Diversity Outbred mice,
with genotypes available. These genotypes are typically obtained
using genotyping arrays such as the 
[GigaMUGA platform](https://www.neogen.com/categories/genotyping-arrays/gigamuga/).
One can also run `demuxlet` *without* genotypes (i.e. `freemuxlet`) however
we do generally recommend genotyping Diversity Outbred mice, so in this repository
we focus on the setting where genotypes *are* available.
For inbred mouse strains you should be able to use genetic variation
cataloged by the 
[Mouse Genomes Project](https://www.sanger.ac.uk/data/mouse-genomes-project/) to
construct a VCF file and use this to run `demuxlet` in an analogous fashion
starting on step 2 below.

In all instances, we use the output of 10X CellRanger, specifically
the filtered feature-barcode matrix. We then use `demuxlet` to deconvolute a strain
ancestry for each cell, and to identify mixed background doublets.

## Singularity containers

For reproducibility, we have produced singularity containers that contain all of the
software used throughout this pipeline. You can find links to these
containers here:

 * [demuxlet/popscle](https://cloud.sylabs.io/library/daskelly/mouse_demuxlet/popscle)
 * [picard](http://jaxreg.jax.org/containers/334)
 * [R4.3 with tidyverse, qtl2, and other packages](https://cloud.sylabs.io/library/daskelly/mouse_demuxlet/tidyqtl2_r)
 * [samtools](https://cloud.sylabs.io/library/daskelly/mouse_demuxlet/samtools)


## Overview of process

 1. Construct VCF file for samples in pool
 2. Reorder 10X BAM file to play well with VCF in step 1
 3. Run `dsc-pileup` to generate pileups around known variants
 4. Run `demuxlet` to deconvolute strain identity of cells

## Construct pooled sample VCF

## Reorder 10X BAM file to play well with VCF

## Run `dsc-pileup`

## Run `demuxlet`

## Interpreting output


example allele probs (genotypes) -- from qtl2???

