#! /bin/bash

base=/net/cephfs/home/mathmu/scratch/goeckeritz-model
scripts=$base/scripts
models=$base/models

corpus=train
model_name=ensemble
model_paths="$models/baseline $models/baseline_2 $models/baseline_3 $models/baseline_4 $models/baseline_5"

batch_size=16

exit "chunk size too high! adapt to batch 16 case"
chunk_size=10000

. $scripts/decode_parallel_generic.sh
