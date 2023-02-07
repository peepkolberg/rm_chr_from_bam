#!/bin/bash

#SBATCH --job-name=rm_chr
#SBATCH --partition=amd
#SBATCH --time=1-00:00:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G

module load any/samtools
module load nextflow

nextflow -log logs run rm_chr.nf -profile tartu_hpc \
    --samples data/samples.tsv \
#    -resume
