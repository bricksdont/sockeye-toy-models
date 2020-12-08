# Investigating significance testing of NMT models

This is a quick test to see if setting a different random seed can cause significant differences in
translation quality according to paired bootstrap.

The data I am using is WMT 14 EN-DE, all the preprocessing and training options are widely used.

Here are some ways to reproduce my results, ordered by convenience:

## Single command

Run the following on an instance that has Python 3 and access to 1 GPU:

    curl -sL https://gist.githubusercontent.com/bricksdont/b5118b8b08b8270f15dc595e9579b48b/raw/fd35abbedfb839531253a91e7e0a2ceb5a9a0052/bootsTRAP.sh | bash

## More details about individual steps

Clone the code to your machine:

    git clone https://github.com/bricksdont/sockeye-toy-models
    cd sockeye-toy-models
    checkout bootsTRAP

### Running scripts directly

Then run

    bash scripts/all.sh

Or the individual steps in `scripts/all.sh`.

### Submitting scripts to a batch system

If you are on a SLURM system, you can probably submit similar to:

    bash scripts/submit.sh

## Example Output

Here is an example output of the evaluation part:

```
evaluations/baseline_1/bleu
BLEU+case.mixed+numrefs.1+smooth.exp+tok.13a+version.1.4.14 = 24.723 55.9/30.3/18.6/11.9 (BP = 1.000 ratio = 1.048 hyp_len = 60326 ref_len = 57579)
evaluations/baseline_2/bleu
BLEU+case.mixed+numrefs.1+smooth.exp+tok.13a+version.1.4.14 = 25.062 56.2/30.7/18.9/12.1 (BP = 1.000 ratio = 1.048 hyp_len = 60351 ref_len = 57579)

evaluations/bootstrap
Win ratio: sys1=0.030, sys2=0.970, tie=0.030
(sys2 is superior with p value p=0.030)

sys1 mean=0.247, median=0.247, 95% confidence interval=[0.240, 0.254]
sys2 mean=0.251, median=0.251, 95% confidence interval=[0.244, 0.258]
```

Also see the file `results.txt`.
