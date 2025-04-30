#!/bin/bash
SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
source ${SCRIPTS_DIR}/utils.sh

check_in_docker $0

GRPC_VRERSION=v1.71.1
WORK_DIR="$(cd "${SCRIPTS_DIR}/.." && pwd)"
SOURCE_DIR=${WORK_DIR}/_deps/grpc-src
BUILD_DIR=${WORK_DIR}/_deps/grpc-build
mkdir -p ${SOURCE_DIR}
mkdir -p ${BUILD_DIR}

BUILD_ENV=$(git branch --show-current)
BUILD_ARCH=$(uname -m)

build_grpc() {
    git clone https://github.com/grpc/grpc.git -b ${GRPC_VRERSION} --recurse-submodules ${SOURCE_DIR}
    cmake -B ${BUILD_DIR} -S ${SOURCE_DIR} -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/install
    cmake --build ${BUILD_DIR} -- -j10
    cmake --install ${BUILD_DIR}
    tar -czvf ${WORK_DIR}/grpc_${GRPC_VRERSION}_${BUILD_ENV}_${BUILD_ARCH}.tar.gz -C ${BUILD_DIR}/install .
}

build_grpc