#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s puppet-lint ; then
    echo "Running Puppet syntax lint..."

    set -e
    puppet-lint "$file"
    set +e
  else
    echo "Can't run the Puppet syntax linter because the puppet-lint executable isn't in the PATH."
  fi
}

case "${1}" in
  --about )
    echo "Puppet syntax lint."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(pp)') ; do
      test_file "${file}"
    done
    ;;
esac
