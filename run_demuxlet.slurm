#!/bin/bash

#SBATCH --job-name=run_demuxlet
#SBATCH --partition=compute  # ==queue
#SBATCH --nodes=1            # number of nodes
#SBATCH --ntasks=1           # number of cores
#SBATCH --mem=30GB          # memory pool for all cores
#SBATCH --time=04:00:00      # time (HH:MM:SS)
#SBATCH --output=%x.o%A_%a      # stdout and stderr
#SBATCH --array=1

module load singularity

REPO_BASE=$(pwd)
VCF=impute_full.vcf.gz
OUTDIR=$REPO_BASE/demuxlet_results

singularity run $REPO_BASE/containers/popscle-1.0.sif demuxlet \
    --plp $OUTDIR/toy \
    --vcf <(zcat $VCF) \
    --out $OUTDIR \
    --sam-verbose 10000000 --vcf-verbose 250000 \
    --alpha 0.0 --alpha 0.5 --tag-group CB --tag-UMI UB \
    --field GT 
