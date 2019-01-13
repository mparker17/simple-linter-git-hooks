#!/usr/bin/env bash

# Prerequisites:
# - [GNU Bourne-again Shell](https://www.gnu.org/software/bash/)
#   Check if it is installed by running:
#
#       bash
#
#   ... if that does not result in an "unknown command" (or similar) message,
#   then this script should work fine. To return to your regular shell, type
#   `exit` and press enter/return.

# This is based upon another script which had the following license:
#
# Copyright (c) 2010-2014, Benjamin C. Meyer <ben@meyerhome.net>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the project nor the
#    names of its contributors may be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

function test_file {
    file="${1}"

    if [ ! -f "${file}" ] ; then
        return
    fi

    echo "Running bash syntax lint..."
    # Set -e before and +e after for _required_ linters (i.e.: that will
    # prevent commit, e.g.: syntax linters).
    # Set +e before and -e after for _optional_ linters (i.e.: that will
    # only output messages upon commit, e.g.: style linters).
    set -e
    bash -n "${file}"
    set +e
}

case "${1}" in
    --about )
        echo "Bash syntax lint."
        ;;
    * )
        for file in $(git diff-index --cached --name-only HEAD | grep -E '\.(sh)') ; do
            test_file "${file}"
        done
        ;;
esac
