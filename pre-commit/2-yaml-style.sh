#!/usr/bin/env bash

# Prerequisites:
# - [yamllint](https://yamllint.readthedocs.io)
#   Check if it is installed by running:
#
#       bash -c 'command -v yamllint'
#
#   ... if that returns a path, then this script should work fine.

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v yamllint)" ] ; then
        echo "Running YAML style lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set +e
        yamllint "$file"
        set -e
    else
        echo "Can't run the YAML style linter because the yamllint executable isn't in the PATH."
    fi
}

case "${1}" in
    --about )
        echo "YAML style lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(yaml|yml)') ; do
            test_file "${file}"
        done
    ;;
esac
