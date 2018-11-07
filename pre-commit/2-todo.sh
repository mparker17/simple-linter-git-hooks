#!/usr/bin/env bash

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    echo "Running TODO comment lint..."
    # Set -e before and +e after for _required_ linters (i.e.: that will prevent
    # commit, e.g.: syntax linters).
    # Set +e before and -e after for _optional_ linters (i.e.: that will only
    # output messages upon commit, e.g.: style linters).
    set +e
    grep -i -E '\btodo\b' "$file"
    set -e
}

case "${1}" in
    --about )
        echo "Check for TODOs left in the code."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -v -E '\.(gif|gz|ico|jpeg|jpg|png|phar|exe|svgz|tff)') ; do
            test_file "${file}"
        done
    ;;
esac
