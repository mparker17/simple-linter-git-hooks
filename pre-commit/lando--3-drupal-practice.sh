#!/usr/bin/env bash

# Prerequisites:
# - [The Lando development environment](https://lando.dev/)
# - [Lando tooling for lint-practice-php](https://github.com/mparker17/drupal-lando_snippets/blob/master/tooling/lint-practice-php.yml)

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    if [ -x "$(command -v lando)" ] ; then
        echo "Running Drupal Best-Practices style lint..."

        # Set -e before and +e after for _required_ linters (i.e.: that will prevent
        # commit, e.g.: syntax linters).
        # Set +e before and -e after for _optional_ linters (i.e.: that will only
        # output messages upon commit, e.g.: style linters).
        set +e
        lando lint-practice-php "$file"
        set -e
    else
        echo "Can't run Drupal Best-Practices style linter because the lando executable isn't on the PATH."
    fi
}

case "${1}" in
    --about )
        echo "Drupal Best-Practices style lint."
    ;;

    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(php|inc|module|install|profile|test)') ; do
            test_file "${file}"
        done
    ;;
esac
