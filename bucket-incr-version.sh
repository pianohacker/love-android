#!/usr/bin/env bash

set -eu

cd "$(dirname $0)"

pushd ~/p/bucket
	VERSION_NAME="$(date +%F)-$(git describe --abbrev --always HEAD)"
	git diff --check --quiet
	if git describe --tag --exact 2> /dev/null; then
		echo 'Error: commit already tagged' >&2
		exit 1
	fi
	git tag $VERSION_NAME
popd

perl -i -pne 's/VERSION_CODE=(\d+)/"VERSION_CODE=".($1 + 1)/e' version.properties
perl -i -pne 's/VERSION_NAME=.*/VERSION_NAME='$VERSION_NAME'/' version.properties
