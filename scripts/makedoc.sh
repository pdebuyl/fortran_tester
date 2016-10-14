#!/bin/bash -
#
# File:        makedoc.sh
#
# Description: build API html documentation of fortran_tester project
#
# License:     GPL3+
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

set -ev # echo what we are doing and fail on errors
GITREPO=$1
git config --global user.name "Stefano Zaghi"
git config --global user.email "stefano.zaghi@gmail.com"
git clone --branch=gh-pages https://${GH_TOKEN}@github.com/$GITREPO.git doc/html
ford doc/main_page.md --debug
mv doc/html/publish/* doc/html/
rm -rf doc/html/publish/
cd doc/html
git add -f --all './*'
git commit -m "Travis CI autocommit from travis build ${TRAVIS_BUILD_NUMBER}"
git push -f origin gh-pages > /dev/null 2>&1
cd -
