#!/usr/bin/env bash

# shellcheck disable=SC2034
GREP_OPTIONS=""

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

  if which -s phpcs ; then
    echo "Running Drupal Best-Practices style lint..."

    set -e
    phpcs --standard=DrupalPractice -- "$file"
    set +e
  else
    echo "Can't run Drupal Best-Practices style linter because the phpcs executable isn't on the PATH."
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
