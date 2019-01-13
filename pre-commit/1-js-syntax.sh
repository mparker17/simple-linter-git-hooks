#!/usr/bin/env bash

# Prerequisites:
# - [Node.js](https://nodejs.org/)
#   Check if it is installed by running:
#
#       bash -c 'command -v node'
#
#   ... if that returns a path, then this script should work fine.

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v node)" ] ; then
        echo "Running JS syntax lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set -e
        node -c "$file"
        set +e
    else
        echo "Can't run JS syntax linter because the node executable isn't in the PATH."
    fi
}

case "${1}" in
    --about )
        echo "JS syntax lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(js)') ; do
            test_file "${file}"
        done
    ;;
esac
