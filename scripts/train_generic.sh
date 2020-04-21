# calling script needs to set:

# $data
# $model_path
# $additional_args
# $num_threads
# $src
# $trg

echo "additional args: "
echo "$additional_args"

echo "Starting: $model_path"


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
			--checkpoint-interval 200 \
      --decode-and-evaluate 10 \
      --num-words 10000 \
      --weight-tying \
      --weight-tying-type src_trg_softmax \
      -o $model_path $additional_args
