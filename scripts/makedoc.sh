#!/bin/bash -
#
# File:        makedoc.sh
#
# Description: build API html documentation of fortran_tester project
#
# License:     BSD
#
# Copyright (C) 2015-2016 Pierre de Buyl and contributors

# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#   a.  Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#   b. Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#   c. Neither the name of the <organization> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set -ev # echo what we are doing and fail on errors
GITREPO=$1
USERNAME=$2
USEREMAIL=$3
git config --global user.name "$USERNAME"
git config --global user.email "$USEREMAIL"
git clone --branch=gh-pages https://${GH_TOKEN}@github.com/$GITREPO.git doc/html
rm -rf doc/html/*
ford doc/main_page.md --debug
mv doc/html/publish/* doc/html/
rm -rf doc/html/publish/
cd doc/html
git add -f --all './*'
git commit -m "Travis CI autocommit from travis build ${TRAVIS_BUILD_NUMBER}"
git push -f origin gh-pages > /dev/null 2>&1
cd -
