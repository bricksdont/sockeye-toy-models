#! /bin/bash

# calling script needs to set

# $base
# $hyp1
# $hyp2
# $ref
# $output

tools=$base/tools
scripts=$base/scripts

for unused in pseudo_loop; do

    if [[ -s $output ]]; then
      continue
    fi

    python $scripts/paired-bootstrap.py $ref $hyp1 $hyp2 > $output

    echo "$output"
    cat $output

done
