#!/bin/bash
[ "${DEBUG}" ] && set -x

function ascii_clean() {
    (
    if (( $# == 0 )) ; then
        strip-ansi < /dev/stdin
    else
        strip-ansi < "$1"
    fi
    ) | tr -dc '[:print:][:space:][:alpha:][:punct:]'
}

ascii_clean "$@"