#!/bin/bash

# S3IT
base=/net/cephfs/home/mathmu/scratch/goeckeritz-model

sbatch --cpus-per-task=16 --time=12:00:00 --mem=64G --partition=hydra $1 $base

