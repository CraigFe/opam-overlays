#!/usr/bin/env bash

OVERLAYS_REPO=${1:-overlays}

PACKAGES=(`opam list --repo="$OVERLAYS_REPO" -A -s`)

if [[ ${#PACKAGES[@]} -eq 0 ]]; then
	echo "No package found for repository $OVERLAYS_REPO"
	exit 2
fi

STATUS=0

for pkg in `opam show -f package "${PACKAGES[@]}"`; do
	if ! [[ $pkg = *"+dune" ]]; then
		echo "New version upstream: $pkg"
		STATUS=1
	fi
done

exit $STATUS
