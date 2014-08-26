#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s php ; then
    echo "Running PHP syntax lint..."

    set -e
    php -l "$file"
    set +e
  else
    echo "Can't run PHP syntax linter because the php executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "PHP syntax lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(php|inc|module|install|profile|test)') ; do
      test_file "${file}"
    done
    ;;
esac
