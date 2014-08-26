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

    # See http://eslint.org/docs/integrations/
    e=$(eslint "$file")
    echo "$e"
    if [[ "$e" != *"0 problems"* ]]; then
      echo "ERROR: Check eslint hints."
      exit 1
    fi
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
