#!/bin/bash

source /net/cephfs/home/mathmu/scratch/goeckeritz-model/venvs/sockeye3/bin/activate
module unuse /apps/etc/modules/start/
module use /sapps/etc/modules/start/
module load volta cuda/10.0

base=/net/cephfs/home/mathmu/scratch/goeckeritz-model

# S3IT
sbatch --qos=vesta --time=72:00:00 --gres gpu:Tesla-V100:1 --cpus-per-task 3 --mem 48g $1 $base
