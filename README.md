# Investigating randomness / determinism

    git clone https://github.com/bricksdont/sockeye-toy-models
    cd sockeye-toy-models
    checkout debug_init

Make changes in

- `scripts/download_install_packages.sh` if your CUDA version is not 10.1
- `scripts/train.sh` if on CPU you would like to use a different number of threads, or a different GPU device id

Then run

    bash scripts/all.sh

Or the individual steps in `scripts/all.sh`.
