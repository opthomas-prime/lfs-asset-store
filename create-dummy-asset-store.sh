#!/usr/bin/env bash

function create-assets {
	seq="a b c d"
	for i in $seq; do
		for j in $seq; do
			for k in $seq; do
				dd if=/dev/urandom of=assets/$i$j$k.asset bs=1M count=5
			done
		done
	done
}

# init repo, setup lfs
git init
git lfs install
git lfs track "*.asset"
git add .gitattributes

# create asset folder
mkdir -p assets

set -xe

# populate asset folder
for v in v1 v2 v3 v4 v5; do
	# create assets for this version
	create-assets
	# commit this version
	git add assets
	git commit -m "$v assets"
	git tag $v
done
