#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
prepared=$base/prepared
models=$base/models

mkdir -p $models

src=en
trg=de

num_threads=1

# measure time

SECONDS=0

######################################################################################################

# CPU, without prepared data, no dropout, no restarts

######################################################################################################

source $base/venvs/sockeye3-cpu/bin/activate

# --use-cpu, without prepared data, seed = 1

model_path=$models/cpu.unprepared.seed1.nodropout.norestart.run1
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg"

. $scripts/train_generic.sh

# --use-cpu, without prepared data, seed = 1, repeat

model_path=$models/cpu.unprepared.seed1.nodropout.norestart.run2
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg"

. $scripts/train_generic.sh

# --use-cpu, without prepared data, seed = 2

model_path=$models/cpu.unprepared.seed2.nodropout.norestart.run1
additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg"

. $scripts/train_generic.sh

######################################################################################################

# CPU, prepared data, no dropout, no restarts

######################################################################################################

# --use-cpu, prepared data, seed = 1

model_path=$models/cpu.prepared.seed1.nodropout.norestart.run1
additional_args="--use-cpu --seed=1 -d $prepared"

. $scripts/train_generic.sh

# --use-cpu, prepared data, seed = 1, repeat

model_path=$models/cpu.prepared.seed1.nodropout.norestart.run2
additional_args="--use-cpu --seed=1 -d $prepared"

. $scripts/train_generic.sh

# --use-cpu, prepared data, seed = 2

model_path=$models/cpu.prepared.seed2.nodropout.norestart.run1
additional_args="--use-cpu --seed=2 -d $prepared"

. $scripts/train_generic.sh


######################################################################################################

# GPU, without prepared data, no dropout, no restarts

######################################################################################################

deactivate
source $base/venvs/sockeye3-gpu/bin/activate

# --use-cpu, without prepared data, seed = 1

model_path=$models/cpu.unprepared.seed1.nodropout.norestart.run1
additional_args="--device-ids 0 --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg"

. $scripts/train_generic.sh

# --use-cpu, without prepared data, seed = 1, repeat

model_path=$models/cpu.unprepared.seed1.nodropout.norestart.run2
additional_args="--device-ids 0 --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg"

. $scripts/train_generic.sh

# --use-cpu, without prepared data, seed = 2

model_path=$models/cpu.unprepared.seed2.nodropout.norestart.run1
additional_args="--device-ids 0 --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg"

. $scripts/train_generic.sh

######################################################################################################

# GPU, prepared data, no dropout, no restarts

######################################################################################################

# --use-cpu, prepared data, seed = 1

model_path=$models/cpu.prepared.seed1.nodropout.norestart.run1
additional_args="--device-ids 0 --seed=1 -d $prepared"

. $scripts/train_generic.sh

# --use-cpu, prepared data, seed = 1, repeat

model_path=$models/cpu.prepared.seed1.nodropout.norestart.run2
additional_args="--device-ids 0 --seed=1 -d $prepared"

. $scripts/train_generic.sh

# --use-cpu, prepared data, seed = 2

model_path=$models/cpu.prepared.seed2.nodropout.norestart.run1
additional_args="--device-ids 0 --seed=2 -d $prepared"

. $scripts/train_generic.sh

######################################################################################################

# with dropout: --embed-dropout 0.2:0.2

echo "time taken:"
echo "$SECONDS seconds"
