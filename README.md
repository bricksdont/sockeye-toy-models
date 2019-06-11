# sockeye-toy-models: Reconstruction

This repo provides sample code that eventually trains a toy Sockeye model with reconstruction. It downloads and installs all software and data,
preprocesses data and trains a model. After training a baseline model, it shows how to continue training with reconstruction.

All commands assume training and translation should run on **GPU**,
rather than **CPU**. If this is not true for your setup, you will need to change the scripts.
Also, if you have a multicore machine, consider increasing `num_threads` in the scripts.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/bricksdont/sockeye-toy-models
    cd sockeye-toy-models

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

To upgrade Sockeye from the reconstruction branch without changing anywith else later, run

    ./scripts/upgrade_sockeye.sh

Download and split data:

    ./scripts/download_split_data.sh

Preprocess data:

    ./scripts/preprocess.sh

a) If you have access to a baseline model, run a script similar to:

    ./scripts/download_baseline_model.sh

b) If you need to train from scratch, run

    ./scripts/train_baseline.sh

Then continue training with reconstruction:

    ./scripts/train_reconstructor.sh

The training process can be interrupted at any time. Interrupted trainings can usually be continued from the point where they left off.

Evaluate a trained model with

    ./scripts/evaluate.sh
