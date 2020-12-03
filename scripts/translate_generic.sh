#! /bin/bash

# calling script needs to set

# $base
# $input
# $output_bpe
# $output_tokenized
# $output
# $models_sub

# cloned from https://github.com/bricksdont/moses-scripts
MOSES=$base/tools/moses-scripts/scripts

for unused in pseudo_loop; do

    if [[ -s $output ]]; then
      echo "Translations exist: $output"

      num_lines_input=$(cat $input | wc -l)
      num_lines_output=$(cat $output | wc -l)

      if [[ $num_lines_input == $num_lines_output ]]; then
          echo "output exists and number of lines are equal to input:"
          echo "$input == $output"
          echo "$num_lines_input == $num_lines_output"
          echo "Skipping."
          continue
      else
          echo "$input != $output"
          echo "$num_lines_input != $num_lines_output"
          echo "Repeating step."
      fi
    fi

    # 1-best, beam 5

    OMP_NUM_THREADS=1 python -m sockeye.translate \
            -i $input \
            -o $output_bpe \
            -m $models_sub \
            --beam-size 5 \
            --length-penalty-alpha 1.0 \
            --device-ids 0 \
            --batch-size 64 \
            --disable-device-locking

    # undo pieces

    cat $output_bpe | sed 's/\@\@ //g' > $output_tokenized

    # detokenize

    cat $output_tokenized | $MOSES/tokenizer/detokenizer.perl -l $trg > $output

done
