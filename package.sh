#!/bin/bash
# package all files except the ones mentioned in exclude list in typst.toml

exclude_patterns=$(awk '/exclude = \[/,/\]/ {if ($0 !~ /exclude = \[/ && $0 !~ /\]/) print $0}' typst.toml | sed 's/[",]//g' | sed 's/^[ \t]*//' | sed 's/\/$//')
tar_args=$(while IFS= read -r line; do echo " --exclude=$line"; done <<<"$exclude_patterns")
version=$(awk '/version =/ {print $3}' typst.toml | sed 's/"//g')
tar_args+=" --exclude-vcs-ignores -czf ../glossarium-$version.tar.gz ."
tar $tar_args
tar -tf $HOME/glossarium-$version.tar.gz
read -p "Press enter to continue"
rm -rf $HOME/packages
git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:typst/packages
cd $HOME/packages
git sparse-checkout init
git sparse-checkout set packages/preview/glossarium
git checkout main
mkdir packages/preview/glossarium/$version
tar -xvf $HOME/glossarium-$version.tar.gz -C packages/preview/glossarium/$version
git add packages
git commit
gh repo fork
gh repo set-default typst/packages
git push --force origin
gh pr create --fill
