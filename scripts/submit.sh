#! /bin/bash

scripts=`dirname "$0"`
base=$(readlink -m $scripts/..)

module load volta cuda/10.2

logs=$base/logs

mkdir -p $logs

SLURM_DEFAULT_FILE_PATTERN="slurm-%j.out"
SLURM_LOG_ARGS="-o $logs/$SLURM_DEFAULT_FILE_PATTERN -e $logs/$SLURM_DEFAULT_FILE_PATTERN"

SLURM_ARGS="--qos=vesta --time=72:00:00 --gres gpu:Tesla-V100-32GB:1 --cpus-per-task 1 --mem 16g"

sbatch $SLURM_ARGS $SLURM_LOG_ARGS $scripts/all.sh $base
