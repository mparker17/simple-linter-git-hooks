#!/usr/bin/env bash

# Prerequisites:
# - [Rubocop](https://github.com/bbatsov/rubocop#installation)
#   Check if it is installed by running:
#
#       bash -c 'command -v rubocop'
#
#   ... if that returns a path, then this script should work fine.

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v rubocop)" ] ; then
        echo "Running Ruby style lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set +e
        rubocop "$file"
        set -e
    else
        echo "Can't run the Ruby style linter because the rubocop executable isn't in the PATH."
    fi
}

case "${1}" in
    --about )
        echo "Ruby style lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(rb)') ; do
            test_file "${file}"
        done
    ;;
esac
