#!/bin/bash

check_in_docker() {
    if [ ! -f /.dockerenv ]; then
        echo "$1 is intended to be run inside a Docker container."
        exit 1
    fi
}

cmake_build_repo() {
    local GIT_URL=$1
    local GIT_TAG=$2
    local SCRIPTS_DIR=$3
    local WORK_DIR=$(cd "${SCRIPTS_DIR}/.." && pwd)
    local REPO_NAME=$(basename -s .git ${GIT_URL})
    local SOURCE_DIR=${WORK_DIR}/_deps/${REPO_NAME}-src
    local BUILD_DIR=${WORK_DIR}/_deps/${REPO_NAME}-build

    mkdir -p ${SOURCE_DIR}
    mkdir -p ${BUILD_DIR}

    git clone ${GIT_URL} -b ${GIT_TAG} --recurse-submodules ${SOURCE_DIR}
    cmake -B ${BUILD_DIR} -S ${SOURCE_DIR} -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/install
    cmake --build ${BUILD_DIR} -- -j10
    cmake --install ${BUILD_DIR}
    tar -czvf ${WORK_DIR}/${REPO_NAME}_${GIT_TAG}_$(git branch --show-current)_$(uname -m).tar.gz -C ${BUILD_DIR}/install .
}