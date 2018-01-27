#!/usr/bin/env bash

wget --no-check-certificate https://github.com/git-lfs/git-lfs/archive/v2.3.4.tar.gz
tar xvf v2.3.4.tar.gz
cd git-lfs-2.3.4
./script/bootstrap 
cd bin

set -eu

prefix="/usr/local"

if [ "${PREFIX:-}" != "" ] ; then
  prefix=${PREFIX:-}
elif [ "${BOXEN_HOME:-}" != "" ] ; then
  prefix=${BOXEN_HOME:-}
fi

mkdir -p $prefix/bin
rm -rf $prefix/bin/git-lfs*

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
  for g in git*; do
    install $g "$prefix/bin/$g"
  done
popd > /dev/null

PATH+=:$prefix/bin
git lfs install
