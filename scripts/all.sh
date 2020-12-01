#! /bin/bash

# calling script needs to set:
# $base

base=$1
scripts=$base/scripts

src=en
trg=de

# fail if subprocess fails

set -e

if [[ ! -d $base/venvs ]]; then

    . $scripts/make_virtualenv.sh

    . $scripts/download_install_packages.sh

else
    echo "Folder exists: $base/venvs"
    echo "Will skip creating venvs and installing libraries. Delete folders to repeat steps."
fi

. $scripts/download_data.sh

. $scripts/prepare.sh

. $scripts/train.sh

. $scripts/translate.sh

. $scripts/evaluate.sh
