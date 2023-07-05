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
construct a VCF file (for example, using 
[bcftools](https://samtools.github.io/bcftools/bcftools.html) to subset the 
Mouse Genomes Project VCF) and use this to run `demuxlet` in an analogous fashion
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

### Construct pooled sample VCF

See the document [`impute_full_vcf.Rmd`](https://github.com/TheJacksonLaboratory/mouse_demuxlet/blob/main/impute_full_vcf.Rmd). In this document we show how to take inferred 
allele probabilities from a set of Diversity Outbred mice, and produce a VCF 
file that we can use for genetic demultiplexing. 

This file should then be bgzipped. For example:
```bash
 singularity exec containers/samtools_1.10.sif /opt/bin/bgzip impute_full.vcf
```

### Reorder 10X BAM file to play well with VCF

In this repository we include a toy BAM file that consists of two cells that have
been extracted from a real 10X RNA-Seq dataset using the utility 
[`subset-bam`](https://github.com/10XGenomics/subset-bam).
In a real setting you should use the BAM file produced by 10X CellRanger,
called `possorted_genome_bam.bam` in current (May 2023) versions of
CellRanger. 

 * [`reorder_bam.slurm`](https://github.com/TheJacksonLaboratory/mouse_demuxlet/blob/main/reorder_bam.slurm) - `slurm` job submission script for doing this reordering on a cluster. 
 If you have large (or many) BAM files (typical), you will want to use a cluster. This file 
 can also be used as a plain `bash` script. 

### Run `dsc-pileup`

You can read more about running `demuxlet` at
[this link](https://github.com/statgen/popscle). In short, we first run
`dsc-pileup` to generate read pileup files, then we run 
`demuxlet` to deconvolute pooled samples. 

 * [`run_pileup_founders.slurm`](https://github.com/TheJacksonLaboratory/mouse_demuxlet/blob/main/run_pileup_founders.slurm) - `slurm` job submission script for running `dsc-pileup` on 
 a cluster. If you have large (or many) BAM files (typical), you will want to use a cluster. This file can also be used as a plain `bash` script. 

### Run `demuxlet`

You can read more about running `demuxlet` at
[this link](https://github.com/statgen/popscle). In short, we first run
`dsc-pileup` to generate read pileup files, then we run 
`demuxlet` to deconvolute pooled samples. 

 * [`run_demuxlet.slurm`](https://github.com/TheJacksonLaboratory/mouse_demuxlet/blob/main/run_demuxlet.slurm) - `slurm` job submission script for running `demuxlet` on 
 a cluster. This file can also be used as a plain `bash` script. 
