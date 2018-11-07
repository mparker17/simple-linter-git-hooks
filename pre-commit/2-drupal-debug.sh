#!/usr/bin/env bash

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    echo "Running Drupal debug statement lint..."
    # Set -e before and +e after for _required_ linters (i.e.: that will prevent
    # commit, e.g.: syntax linters).
    # Set +e before and -e after for _optional_ linters (i.e.: that will only
    # output messages upon commit, e.g.: style linters).
    set +e
    grep -i -E '\b(dpm|dvm|dpr|dvr|kpr|dargs|dd|ddebug_backtrace|db_queryd|firep|dfb|kint|krumo)\b' $file
    set -e
}

case "${1}" in
    --about )
        echo "Check for Drupal debug statements left in the code."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(php|inc|module|install|profile|test)') ; do
            test_file "${file}"
        done
    ;;
esac
