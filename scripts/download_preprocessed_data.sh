#! /bin/bash

script=`realpath $0`
scripts=`dirname $script`

base=$scripts/..

data=$base/data

mkdir -p $data

wget https://files.ifi.uzh.ch/cl/archiv/2019/mt19/mt19_u6_model.tar.gz -P $data

tar -xzvf $data/mt19_u6_model.tar.gz -C $data

mv $data/mt19_u6_model/data $data

rm -rf $data/mt19_u6_model
rm $data/mt19_u6_model.tar.gz
