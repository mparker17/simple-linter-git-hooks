#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s eslint ; then
    echo "Running JS style lint..."

    # Set -e before and +e after for _required_ linters (i.e.: that will prevent
    # commit, e.g.: syntax linters).
    # Set +e before and -e after for _optional_ linters (i.e.: that will only
    # output messages upon commit, e.g.: style linters).
    set -e
    # Note there's an alternative that works with older versions of eslint at
    # https://coderwall.com/p/zq8jlq/eslint-pre-commit-hook
    # See also http://eslint.org/docs/integrations/
    eslint --plugin drupal "$file"
    set +e
  else
    echo "Can't run JS style linter because the eslint executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "JS style lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(js)') ; do
      test_file "${file}"
    done
    ;;
esac
