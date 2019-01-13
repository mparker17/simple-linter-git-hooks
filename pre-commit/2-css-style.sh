#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

# Prerequisites:
# - [CSSLint](https://github.com/CSSLint/csslint/wiki/Command-line-interface)
#   Check if it is installed by running:
#
#       bash -c 'command -v csslint'
#
#   ... if that returns a path, then this script should work fine.

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v csslint)" ] ; then
        echo "Running CSS style lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set +e
        csslint "$file"
        set -e
    else
        echo "Can't run the CSS style linter because the csslint executable isn't in the PATH."
    fi
}

case "${1}" in
    --about )
        echo "CSS style lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(css)') ; do
            test_file "${file}"
        done
    ;;
esac
