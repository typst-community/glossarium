#!/bin/bash
# package all files except the ones mentioned in exclude list in typst.toml

exclude_patterns=$(awk '/exclude = \[/,/\]/ {if ($0 !~ /exclude = \[/ && $0 !~ /\]/) print $0}' typst.toml | sed 's/[",]//g' | sed 's/^[ \t]*//')
tar_args=$(while IFS= read -r line; do echo " --exclude=$line"; done <<<"$exclude_patterns")
version=$(awk '/version =/ {print $3}' typst.toml | sed 's/"//g')
tar_args+=" --exclude-vcs-ignores -czf ../glossarium-$version.tar.gz ."
tar $tar_args
tar -tf ../glossarium-$version.tar.gz
