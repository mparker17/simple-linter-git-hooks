#!/usr/bin/env bash

# Prerequisites:
# - [SCSS-lint](https://github.com/brigade/scss-lint#installation)
#   Check if it is installed by running:
#
#       bash -c 'command -v scss-lint'
#
#   ... if that returns a path, then this script should work fine.

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v scss-lint)" ] ; then
        echo "Running SCSS style lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set +e
        scss-lint "$file"
        set -e
    else
        echo "Can't run the SCSS style linter because the scss-lint executable isn't in the PATH."
    fi
}

case "${1}" in
    --about )
        echo "SCSS style lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(scss)') ; do
            test_file "${file}"
        done
    ;;
esac
