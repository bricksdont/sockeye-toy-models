#! /usr/bin/python3

import os
import argparse
import logging
import hashlib

# to analyze even better with utils.load_params(param_path)
# from sockeye import utils


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--models", type=str, help="Folder containing trained models", required=True)

    args = parser.parse_args()

    return args


def extract_perplexity_from_log(log_handle):

    finish_lines = []

    for line in log_handle:
        if "Training finished" in line:
            finish_lines.append(line)

    if len(finish_lines) == 0:
        logging.warning("Training not finished: %s", log_handle)
        return None

    last_finish = finish_lines[-1]

    perplexity = last_finish.strip().split(" ")[-1]

    return perplexity


def md5(file_name):
    """
    Taken from: https://stackoverflow.com/a/3431838/1987598

    :param file_name:
    :return:
    """
    hash_md5 = hashlib.md5()
    with open(file_name, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


def check(model_path, restart=False):

    # check final perplexity

    log_path = os.path.join(model_path, "log")

    with open(log_path, "r") as log_handle:
        perplexity = extract_perplexity_from_log(log_handle)

    if perplexity is None:
        return None, None, None

    # check md5sum of init params

    init_path = os.path.join(model_path, "params.00000")
    init_hash = md5(init_path)

    # check md5sum of final params

    if restart:
        final_path = os.path.join(model_path, "params.00010")
    else:
        final_path = os.path.join(model_path, "params.00005")

    final_hash = md5(final_path)

    return perplexity, init_hash, final_hash


def main():

    args = parse_args()

    logging.basicConfig(level=logging.DEBUG)
    logging.debug(args)

    model_paths = []

    for root, dirs, files in os.walk(args.models):
        for dir_ in dirs:
            if dir_.startswith("cpu") or dir_.startswith("gpu"):
                model_path = os.path.abspath(os.path.join(root, dir_))
                model_paths.append(model_path)

    logging.debug("Found the following models: %s", model_paths)

    perplexities, init_hashes, final_hashes = [], [], []

    for model_path in model_paths:

        restart = "norestart" not in model_path

        perplexity, init_hash, final_hash = check(model_path, restart=restart)

        perplexities.append(perplexity)
        init_hashes.append(init_hash)
        final_hashes.append(final_hash)

    # output as tabsep table

    print("NAME\tPERPLEXITY\tINIT_MD5\tFINAL_MD5")

    for model_path, perplexity, init_hash, final_hash in zip(model_paths, perplexities, init_hashes, final_hashes):
        print("\t".join([model_path, perplexity, init_hash, final_hash]))


if __name__ == '__main__':
    main()
