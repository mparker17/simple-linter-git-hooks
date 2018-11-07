#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v node)" ] ; then
        echo "Running JSON syntax lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set -e
        jsonlint -c "$file"
        set +e
    else
        echo "Can't run JSON syntax linter because the jsonlint executable isn't in the PATH."
    fi
}

case "${1}" in
    --about )
        echo "JSON syntax lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(json)') ; do
            test_file "${file}"
        done
    ;;
esac
