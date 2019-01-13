#!/usr/bin/env bash

# Prerequisites:
# - [GNU grep](https://www.gnu.org/software/grep/)
#   The expression in this particular linter is simple enough that other grep
#   variants should work too; but if you're finding that this linter does not
#   work as you expect it to, try installing GNU grep and adjusting this script.
#   Check if a variant of grep is installed by running:
#
#       bash -c 'command -v grep'
#
#   ... if that returns a path, then this script should work fine.

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
    grep -i -E '\b(dpm|dvm|dpr|dvr|kpr|dargs|dd|ddebug_backtrace|db_queryd|firep|dfb|kint|krumo)\b' "$file"
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
