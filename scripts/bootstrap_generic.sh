#! /bin/bash

# calling script needs to set

# $base
# $hyp1
# $hyp2
# $ref
# $output

tools=$base/tools

for unused in pseudo_loop; do

    if [[ -s $output ]]; then
      continue
    fi

    python $tools/paired-bootstrap.py $ref $hyp1 $hyp2 --eval_type bleu_detok > $output

    echo "$output"
    cat $output

done
