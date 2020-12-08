#! /usr/bin/python3

# This script adapted from:
# https://github.com/bricksdont/util-scripts/blob/master/paired-bootstrap.py

import argparse
import logging

import cached_metrics

import numpy as np

from sacrebleu import DEFAULT_TOKENIZER


class Scorer:

    def __init__(self):
        self.args = argparse.Namespace(smooth_method="exp", smooth_value=None, force=False,
                                       short=False, lc=False, tokenize=DEFAULT_TOKENIZER)

        self.metric = cached_metrics.CachedBLEU(self.args)

    def score(self, sys: str, ref: str):
        return self.metric.corpus_score(sys, [ref]).score / 100.

    def cache_info(self) -> None:
        """

        :return:
        """
        logging.debug("Scorer cache:")
        logging.debug(self.metric.cache_info())

    def cache_clear(self) -> None:
        """

        :return:
        """
        self.metric.cache_clear()


def eval_with_paired_bootstrap(gold, sys1, sys2, scorer,
                               num_samples=10000, sample_ratio=0.5):
    """ Evaluate with paired boostrap

    This compares two systems, performing a significance tests with
    paired bootstrap resampling to compare the accuracy of the two systems.

    :param gold: The correct labels
    :param sys1: The output of system 1
    :param sys2: The output of system 2
    :param scorer: scorer instance that can return corpus BLEU score
    :param num_samples: The number of bootstrap samples to take
    :param sample_ratio: The ratio of samples to take every time
    """

    assert (len(gold) == len(sys1))
    assert (len(gold) == len(sys2))

    # Preprocess the data appropriately for they type of eval

    gold = [x.strip() for x in gold]
    sys1 = [x.strip() for x in sys1]
    sys2 = [x.strip() for x in sys2]

    sys1_scores = []
    sys2_scores = []
    wins = [0, 0, 0]
    n = len(gold)
    ids = list(range(n))

    for _ in range(num_samples):

        # Subsample the gold and system outputs

        np.random.shuffle(ids)
        reduced_ids = ids[:int(len(ids) * sample_ratio)]
        reduced_gold = [gold[i] for i in reduced_ids]
        reduced_sys1 = [sys1[i] for i in reduced_ids]
        reduced_sys2 = [sys2[i] for i in reduced_ids]

        # Calculate accuracy on the reduced sample and save stats

        sys1_score = scorer.score(ref=reduced_gold, sys=reduced_sys1)
        sys2_score = scorer.score(ref=reduced_gold, sys=reduced_sys2)
        if sys1_score > sys2_score:
            wins[0] += 1
        if sys1_score < sys2_score:
            wins[1] += 1
        else:
            wins[2] += 1
        sys1_scores.append(sys1_score)
        sys2_scores.append(sys2_score)

    # Print win stats

    wins = [x / float(num_samples) for x in wins]
    print('Win ratio: sys1=%.3f, sys2=%.3f, tie=%.3f' % (wins[0], wins[1], wins[2]))

    if wins[0] > wins[1]:
        print('(sys1 is superior with p value p=%.3f)\n' % (1 - wins[0]))
    elif wins[1] > wins[0]:
        print('(sys2 is superior with p value p=%.3f)\n' % (1 - wins[1]))

    # Print system stats

    sys1_scores.sort()
    sys2_scores.sort()
    print('sys1 mean=%.3f, median=%.3f, 95%% confidence interval=[%.3f, %.3f]' %
          (float(np.mean(sys1_scores)), float(np.median(sys1_scores)), sys1_scores[int(num_samples * 0.025)],
           sys1_scores[int(num_samples * 0.975)]))
    print('sys2 mean=%.3f, median=%.3f, 95%% confidence interval=[%.3f, %.3f]' %
          (float(np.mean(sys2_scores)), float(np.median(sys2_scores)), sys2_scores[int(num_samples * 0.025)],
           sys2_scores[int(num_samples * 0.975)]))


if __name__ == "__main__":
    # execute only if run as a script

    parser = argparse.ArgumentParser()
    parser.add_argument('gold', help='File of the correct answers')
    parser.add_argument('sys1', help='File of the answers for system 1')
    parser.add_argument('sys2', help='File of the answers for system 2')
    parser.add_argument('--num_samples', help='Number of samples to use', type=int, default=10000)
    args = parser.parse_args()

    logging.basicConfig(level=logging.DEBUG)
    logging.debug(args)

    scorer_object = Scorer()

    with open(args.gold, 'r') as f:
        gold_lines = f.readlines()
    with open(args.sys1, 'r') as f:
        sys1_lines = f.readlines()
    with open(args.sys2, 'r') as f:
        sys2_lines = f.readlines()

    eval_with_paired_bootstrap(gold_lines, sys1_lines, sys2_lines, scorer_object, num_samples=args.num_samples)

    scorer_object.cache_info()
