#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models

src=en
trg=de

# measure time

SECONDS=0

#######################################################################################################

# check initial params.00000 equal or not equal, as expected

#######################################################################################################

# should be equal

diff --brief $models/cpu.unprepared.seed1.nodropout.norestart.run1/params.00000 cpu.unprepared.seed1.nodropout.norestart.run2/params.00000

# should be different

diff --brief $models/cpu.unprepared.seed1.nodropout.norestart.run1/params.00000  cpu.unprepared.seed2.nodropout.norestart.run1/params.00000

#######################################################################################################

# check final params equal or not equal, as expected

#######################################################################################################



#######################################################################################################

# check impact of dropout on CPU and GPU (same seeds only!)

#######################################################################################################



#######################################################################################################

# check impact of restarts, no dropout!, compare prepared and unprepared, CPU and GPU

#######################################################################################################




echo "time taken:"
echo "$SECONDS seconds"
