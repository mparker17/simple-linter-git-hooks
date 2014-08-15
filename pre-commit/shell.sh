#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s shellcheck ; then
    echo "Running Shell syntax lint..."

    set -e
    shellcheck "$file"
    set +e
  else
    echo "Can't run Shell syntax linter because the shellcheck executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "Shell syntax lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(sh)') ; do
      test_file "${file}"
    done
    ;;
esac
