# Investigating randomness / determinism

    git clone https://github.com/bricksdont/sockeye-toy-models
    cd sockeye-toy-models
    checkout debug_init

Make changes in

- `scripts/download_install_packages.sh` if your CUDA version is not 10.0
- `scripts/train.sh` if on CPU you would like to use more than 1 thread, or a different GPU device id

Then run

    bash scripts/all.sh
