#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s csslint ; then
    echo "Running CSS style lint with csslint..."

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
    echo "CSS style lint (with csslint)."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(css)') ; do
      test_file "${file}"
    done
    ;;
esac
