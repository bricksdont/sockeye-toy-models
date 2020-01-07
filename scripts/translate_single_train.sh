#! /bin/bash

base=/net/cephfs/home/mathmu/scratch/goeckeritz-model
scripts=$base/scripts

corpus=train
model_name=single
model_paths=$base/models/baseline

batch_size=64
chunk_size=25000

. $scripts/decode_parallel_generic.sh
