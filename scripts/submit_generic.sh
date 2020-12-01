#! /bin/bash

scripts=`dirname "$0"`
base=$(readlink -m $scripts/..)

module load generic

logs=$base/logs

mkdir -p $logs

SLURM_DEFAULT_FILE_PATTERN="slurm-%j.out"
SLURM_LOG_ARGS="-o $logs/$SLURM_DEFAULT_FILE_PATTERN -e $logs/$SLURM_DEFAULT_FILE_PATTERN"

SLURM_ARGS="--cpus-per-task=2 --time=24:00:00 --mem=16G --partition=generic"

sbatch $SLURM_ARGS $SLURM_LOG_ARGS $scripts/all.sh $base
