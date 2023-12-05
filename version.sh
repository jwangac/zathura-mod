#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ $# -eq 1 ]]; then
    dpkg -s $1 | grep Version | awk '{print $2}' >version
fi

if [[ $# -eq 2 && "$2" == "check" ]]; then
    FILE_VERSION=$(cat version)
    CMD_VERSION=$(dpkg -s $1 | grep Version | awk '{print $2}')
    if [ "$FILE_VERSION" != "$CMD_VERSION" ]; then
        if ! notify-send "$1-mod" "Version changed. Need rebuild." ; then
            echo "Version of $1 in apt changed."
            exit 1
        fi
    fi
fi
