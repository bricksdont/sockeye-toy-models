#! /usr/bin/python3

import os
import argparse
import logging


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--models", type=str, help="Folder containing trained models", required=True)

    args = parser.parse_args()

    return args


def main():

    args = parse_args()

    logging.basicConfig(level=logging.DEBUG)
    logging.debug(args)

    model_paths = []

    for root, dirs, files in os.walk(args.models):
        for dir_ in dirs:
            if dir_.startswith("cpu") or dir_.startswith("gpu"):
                model_path = os.path.join(root, dir_)
                model_paths.append(model_path)

    logging.debug("Found the following models: %s", model_paths)


if __name__ == '__main__':
    main()
