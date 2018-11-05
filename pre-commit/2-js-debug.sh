#!/usr/bin/env bash

function test_file {
  file="${1}"

  if [ ! -f "${file}" ] ; then
    return
  fi

	echo "Running JS debug statement lint..."
  # Set -e before and +e after for _required_ linters (i.e.: that will prevent
  # commit, e.g.: syntax linters).
  # Set +e before and -e after for _optional_ linters (i.e.: that will only
  # output messages upon commit, e.g.: style linters).
  set +e
  grep -i -E '\bconsole\.(assert|clear|count|countReset|debug|dir|dirxml|error|exception|group|groupCollapsed|groupEnd|info|log|profile|profileEnd|table|time|timeEnd|timeLogtimeStamp|trace|warn)\b' $file
  set -e
}

case "${1}" in
  --about )
    echo "Check for Drupal debug statements left in the code."
    ;;

  * )
    for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(js)') ; do
      test_file "${file}"
    done
    ;;
esac
