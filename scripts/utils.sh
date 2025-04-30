#!/bin/bash

check_in_docker() {
    if [ ! -f /.dockerenv ]; then
        echo "$1 is intended to be run inside a Docker container."
        exit 1
    fi
}