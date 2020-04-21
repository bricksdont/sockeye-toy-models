# calling script needs to set:

# $data
# $model_path
# $additional_args
# $num_threads
# $src
# $trg

echo "additional args: "
echo "$additional_args"


OMP_NUM_THREADS=$num_threads python -m sockeye.train \
			-vs $data/dev.bpe.$src \
      -vt $data/dev.bpe.$trg \
      --encoder=transformer \
      --decoder=transformer \
      --num-layers=1:1 \
      --transformer-model-size=64 \
      --transformer-attention-heads=1 \
      --transformer-feed-forward-num-hidden=128 \
      --num-embed 64 \
			--num-layers 1:1 \
			--checkpoint-frequency 500 \
      --max-seq-len 60:60 \
      --decode-and-evaluate 500 \
      -o $model_path \
			--max-seconds 600 $additional_args
