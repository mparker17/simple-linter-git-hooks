#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if which -s phpcs ; then
        echo "Running Drupal style lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set +e
        phpcs --standard=Drupal -- "$file"
        set -e
    else
        echo "Can't run Drupal style linter because the phpcs executable isn't on the PATH."
    fi
}

case "${1}" in
    --about )
        echo "Drupal style lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(php|inc|module|install|profile|test)') ; do
            test_file "${file}"
        done
    ;;
esac
