#!/bin/bash
SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
source ${SCRIPTS_DIR}/utils.sh

check_in_docker $0

GIT_URL=https://github.com/protocolbuffers/protobuf.git
GIT_TAG=v4.25.7

cmake_build_repo ${GIT_URL} ${GIT_TAG} ${SCRIPTS_DIR}