#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

. $scripts/make_virtualenv.sh

. $scripts/download_install_packages.sh

. $scripts/download_data.sh

. $scripts/prepare.sh

. $scripts/train.sh

. $scripts/investigate.sh
