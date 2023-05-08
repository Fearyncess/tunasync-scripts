#!/bin/bash

BOOST_REPO_URL="https://github.com/boostorg/boost.git"
REAL_TUNASYNC_WORKING_DIR="$TUNASYNC_WORKING_DIR"

git clone --depth=1 "${BOOST_REPO_URL}" /tmp/boost-repo
GIT_DIR=/tmp/boost-repo/.git git submodule init
echo "${BOOST_REPO_URL}" > /tmp/boost-list
cat /tmp/boost-repo/.gitmodules | grep 'url = ' | sed 's#\.\.\/#https://github.com/boostorg/#g' | cut -d ' ' -f 3 >> /tmp/boost-list
cat /tmp/boost-list | while read line
do
  SUBMOD_NAME=$(echo $line | cut -d '/' -f 5)
  SUBMOD_URL="$line"
  TUNASYNC_WORKING_DIR="${REAL_TUNASYNC_WORKING_DIR}/${SUBMOD_NAME}" TUNASYNC_UPSTREAM_URL="$SUBMOD_URL" /home/tunasync-scripts/git.sh
done
