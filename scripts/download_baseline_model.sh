#! /bin/bash

script=`realpath $0`
scripts=`dirname $script`

base=$scripts/..

models=$base/models
mkdir -p $models

wget https://files.ifi.uzh.ch/cl/archiv/2019/mt19/mt19_u6_model.tar.gz -P $models

tar -xzvf $models/mt19_u6_model.tar.gz -C $models

mv $models/mt19_u6_model/models/model_wmt17 $models/model_wmt17_baseline

rm -rf $models/mt19_u6_model
rm $models/mt19_u6_model.tar.gz
