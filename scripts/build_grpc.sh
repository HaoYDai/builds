#!/bin/bash
SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
source ${SCRIPTS_DIR}/utils.sh

check_in_docker $0

GIT_URL=https://github.com/grpc/grpc.git
GIT_TAG=v1.71.1

cmake_build_repo ${GIT_URL} ${GIT_TAG} ${SCRIPTS_DIR}