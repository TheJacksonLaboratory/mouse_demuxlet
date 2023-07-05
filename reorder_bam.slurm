#!/bin/bash

#SBATCH -J reorder_bam
#SBATCH -p compute  # partition (queue)
#SBATCH --nodes=1            # number of nodes
#SBATCH --ntasks=1           # number of cores
#SBATCH --mem=60GB           # memory pool for all cores
#SBATCH --time=24:00:00      # time (HH:MM:SS)
#SBATCH --output=%x.o%A_%a      # stdout and stderr
#SBATCH --array=1

module load singularity

REPO_BASE=$(pwd)
samtools="singularity run $REPO_BASE/containers/samtools_1.10.sif"
picard="singularity run $REPO_BASE/containers/picard_latest.sif"
# file below created using Picard CreateSequenceDictionary
DICT=supporting_files/refdata-gex-mm10-2020-A_autosomes.dict

BAMBASE=supporting_files/toy_10X/toy_reads
BAM=$BAMBASE.bam
# BAM should already be sorted and indexed
#$samtools sort --output-fmt BAM $BAM > out.sorted.bam
#$samtools index out.sorted.bam

# Now we make sure that only autosome and chrX reads are included
$samtools view -hb -L supporting_files/regions.bed $BAM > $BAMBASE.regions.bam
$samtools index $BAMBASE.regions.bam

# Finally, reorder to make sure contigs are in same order as $DICT
$picard ReorderSam -I $BAMBASE.regions.bam -O $BAMBASE.final.bam -SD $DICT \
    --VALIDATION_STRINGENCY SILENT --ALLOW_INCOMPLETE_DICT_CONCORDANCE
$samtools index $BAMBASE.final.bam

rm -f $BAMBASE.regions.bam*
