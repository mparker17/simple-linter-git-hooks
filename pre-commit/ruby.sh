#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s rubocop ; then
    echo "Running Ruby syntax lint..."

    set -e
    rubocop "$file"
    set +e
  else
    echo "Can't run the Ruby syntax linter because the rubocop executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "Ruby syntax lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(rb)') ; do
      test_file "${file}"
    done
    ;;
esac
