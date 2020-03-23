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

    echo "Running USERNAME comment lint..."
    # Set -e before and +e after for _required_ linters (i.e.: that will prevent
    # commit, e.g.: syntax linters).
    # Set +e before and -e after for _optional_ linters (i.e.: that will only
    # output messages upon commit, e.g.: style linters).
    set -e
    { grep -i -E '\bUSERNAME\b' "$file" && test $? = 1; }
    set +e
}

case "${1}" in
    --about )
        echo "Check for instances of USERNAME left in the code."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -v -E '\.(gif|gz|ico|jpeg|jpg|png|phar|exe|svgz|tff)') ; do
            test_file "${file}"
        done
    ;;
esac
