#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models
mkdir -p $models

wget https://files.ifi.uzh.ch/cl/archiv/2019/mt19/mt19_u6_model.tar.gz -P $models

tar -xzvf $models/mt19_u6_model.tar.gz

mv $models/mt19_u6_model $models/model_wmt17_baseline
