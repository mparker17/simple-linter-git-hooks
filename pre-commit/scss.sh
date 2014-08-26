#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s scss-lint ; then
    echo "Running SCSS style lint..."

    set -e
    scss-lint "$file"
    set +e
  else
    echo "Can't run the SCSS style linter because the scss-lint executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "SCSS style lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(scss)') ; do
      test_file "${file}"
    done
    ;;
esac
