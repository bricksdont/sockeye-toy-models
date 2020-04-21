#! /bin/bash

scripts=`dirname "$0"`
base=$(readlink -m $scripts/..)

data=$base/data
prepared=$base/prepared
models=$base/models

mkdir -p $models

src=en
trg=de

num_threads=1
device_id=0

# measure time

SECONDS=0

without_dropout_args="--embed-dropout 0.0:0.0 --transformer-postprocess r:r --transformer-dropout-attention 0.0 --transformer-dropout-act 0.0 --transformer-dropout-prepost 0.0"
with_dropout_args="--embed-dropout 0.2:0.2 --transformer-postprocess dr:dr --transformer-dropout-attention 0.2 --transformer-dropout-act 0.2 --transformer-dropout-prepost 0.2"

######################################################################################################

# CPU, without prepared data, no dropout, no restarts

######################################################################################################

source $base/venvs/sockeye3-cpu/bin/activate

# cpu, without prepared data, seed = 1

model_path=$models/cpu.unprepared.seed1.nodropout.norestart.run1
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 1, repeat

model_path=$models/cpu.unprepared.seed1.nodropout.norestart.run2
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 2

model_path=$models/cpu.unprepared.seed2.nodropout.norestart.run1
additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, without prepared data, dropout, no restarts

######################################################################################################

source $base/venvs/sockeye3-cpu/bin/activate

# cpu, without prepared data, seed = 1

model_path=$models/cpu.unprepared.seed1.dropout.norestart.run1
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 1, repeat

model_path=$models/cpu.unprepared.seed1.dropout.norestart.run2
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 2

model_path=$models/cpu.unprepared.seed2.dropout.norestart.run1
additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, prepared data, no dropout, no restarts

######################################################################################################

# cpu, prepared data, seed = 1

model_path=$models/cpu.prepared.seed1.nodropout.norestart.run1
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 1, repeat

model_path=$models/cpu.prepared.seed1.nodropout.norestart.run2
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 2

model_path=$models/cpu.prepared.seed2.nodropout.norestart.run1
additional_args="--use-cpu --seed=2 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, prepared data, dropout, no restarts

######################################################################################################

# cpu, prepared data, seed = 1

model_path=$models/cpu.prepared.seed1.dropout.norestart.run1
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 1, repeat

model_path=$models/cpu.prepared.seed1.dropout.norestart.run2
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 2

model_path=$models/cpu.prepared.seed2.dropout.norestart.run1
additional_args="--use-cpu --seed=2 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh


######################################################################################################

# GPU, without prepared data, no dropout, no restarts

######################################################################################################

deactivate
source $base/venvs/sockeye3-gpu/bin/activate

# gpu, without prepared data, seed = 1

model_path=$models/gpu.unprepared.seed1.nodropout.norestart.run1
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, without prepared data, seed = 1, repeat

model_path=$models/gpu.unprepared.seed1.nodropout.norestart.run2
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, without prepared data, seed = 2

model_path=$models/gpu.unprepared.seed2.nodropout.norestart.run1
additional_args="--device-ids $device_id --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# GPU, without prepared data, dropout, no restarts

######################################################################################################

deactivate
source $base/venvs/sockeye3-gpu/bin/activate

# gpu, without prepared data, seed = 1

model_path=$models/gpu.unprepared.seed1.dropout.norestart.run1
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, without prepared data, seed = 1, repeat

model_path=$models/gpu.unprepared.seed1.dropout.norestart.run2
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, without prepared data, seed = 2

model_path=$models/gpu.unprepared.seed2.dropout.norestart.run1
additional_args="--device-ids $device_id --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# GPU, prepared data, no dropout, no restarts

######################################################################################################

# gpu, prepared data, seed = 1

model_path=$models/gpu.prepared.seed1.nodropout.norestart.run1
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 1, repeat

model_path=$models/gpu.prepared.seed1.nodropout.norestart.run2
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 2

model_path=$models/gpu.prepared.seed2.nodropout.norestart.run1
additional_args="--device-ids $device_id --seed=2 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# GPU, prepared data, dropout, no restarts

######################################################################################################

# gpu, prepared data, seed = 1

model_path=$models/gpu.prepared.seed1.dropout.norestart.run1
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 1, repeat

model_path=$models/gpu.prepared.seed1.dropout.norestart.run2
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 2

model_path=$models/gpu.prepared.seed2.dropout.norestart.run1
additional_args="--device-ids $device_id --seed=2 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, without prepared data, no dropout, with restarts

######################################################################################################

source $base/venvs/sockeye3-cpu/bin/activate

# cpu, without prepared data, seed = 1

model_path=$models/cpu.unprepared.seed1.nodropout.restart.run1
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 1, repeat

model_path=$models/cpu.unprepared.seed1.nodropout.restart.run2
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 2

model_path=$models/cpu.unprepared.seed2.nodropout.restart.run1
additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, without prepared data, dropout, with restarts

######################################################################################################

source $base/venvs/sockeye3-cpu/bin/activate

# cpu, without prepared data, seed = 1

model_path=$models/cpu.unprepared.seed1.dropout.restart.run1
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 1, repeat

model_path=$models/cpu.unprepared.seed1.dropout.restart.run2
additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, without prepared data, seed = 2

model_path=$models/cpu.unprepared.seed2.dropout.restart.run1
additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, prepared data, no dropout, with restarts

######################################################################################################

# cpu, prepared data, seed = 1

model_path=$models/cpu.prepared.seed1.nodropout.restart.run1
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -d $prepared --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 1, repeat

model_path=$models/cpu.prepared.seed1.nodropout.restart.run2
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -d $prepared --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 2

model_path=$models/cpu.prepared.seed2.nodropout.restart.run1
additional_args="--use-cpu --seed=2 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=2 -d $prepared --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# CPU, prepared data, dropout, with restarts

######################################################################################################

# cpu, prepared data, seed = 1

model_path=$models/cpu.prepared.seed1.dropout.restart.run1
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -d $prepared --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 1, repeat

model_path=$models/cpu.prepared.seed1.dropout.restart.run2
additional_args="--use-cpu --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=1 -d $prepared --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# cpu, prepared data, seed = 2

model_path=$models/cpu.prepared.seed2.dropout.restart.run1
additional_args="--use-cpu --seed=2 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--use-cpu --seed=2 -d $prepared --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh


######################################################################################################

# GPU, without prepared data, no dropout, with restarts

######################################################################################################

deactivate
source $base/venvs/sockeye3-gpu/bin/activate

# gpu, without prepared data, seed = 1

model_path=$models/gpu.unprepared.seed1.nodropout.restart.run1
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, without prepared data, seed = 1, repeat

model_path=$models/gpu.unprepared.seed1.nodropout.restart.run2
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh


# gpu, without prepared data, seed = 2

model_path=$models/gpu.unprepared.seed2.nodropout.restart.run1
additional_args="--device-ids $device_id --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# GPU, without prepared data, dropout, with restarts

######################################################################################################

deactivate
source $base/venvs/sockeye3-gpu/bin/activate

# gpu, without prepared data, seed = 1

model_path=$models/gpu.unprepared.seed1.dropout.restart.run1
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh


# gpu, without prepared data, seed = 1, repeat

model_path=$models/gpu.unprepared.seed1.dropout.restart.run2
additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, without prepared data, seed = 2

model_path=$models/gpu.unprepared.seed2.dropout.restart.run1
additional_args="--device-ids $device_id --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=2 -s $data/train.bpe.$src -t $data/train.bpe.$trg --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# GPU, prepared data, no dropout, with restarts

######################################################################################################

# gpu, prepared data, seed = 1

model_path=$models/gpu.prepared.seed1.nodropout.restart.run1
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 1, repeat

model_path=$models/gpu.prepared.seed1.nodropout.restart.run2
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 2

model_path=$models/gpu.prepared.seed2.nodropout.restart.run1
additional_args="--device-ids $device_id --seed=2 -d $prepared --max-updates 5000 $without_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=2 -d $prepared --max-updates 10000 $without_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

# GPU, prepared data, dropout, with restarts

######################################################################################################

# gpu, prepared data, seed = 1

model_path=$models/gpu.prepared.seed1.dropout.restart.run1
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 1, repeat

model_path=$models/gpu.prepared.seed1.dropout.restart.run2
additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=1 -d $prepared --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

# gpu, prepared data, seed = 2

model_path=$models/gpu.prepared.seed2.dropout.restart.run1
additional_args="--device-ids $device_id --seed=2 -d $prepared --max-updates 5000 $with_dropout_args"

. $scripts/train_generic.sh

additional_args="--device-ids $device_id --seed=2 -d $prepared --max-updates 10000 $with_dropout_args"

. $scripts/train_generic.sh

######################################################################################################

echo "time taken:"
echo "$SECONDS seconds"
