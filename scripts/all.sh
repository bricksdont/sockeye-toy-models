#! /bin/bash

# calling script needs to set:
# $base

base=$1

src=en
trg=de

# fail if subprocess fails

set -e

. $scripts/make_virtualenv.sh

. $scripts/download_install_packages.sh

. $scripts/download_data.sh

. $scripts/prepare.sh

. $scripts/train.sh

. $scripts/translate.sh

. $scripts/evaluate.sh
