#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s csslint ; then
    echo "Running CSS syntax lint..."

    set -e
    csslint "$file"
    set +e
  else
    echo "Can't run the CSS syntax linter because the csslint executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "CSS syntax lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(css)') ; do
      test_file "${file}"
    done
    ;;
esac
