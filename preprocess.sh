#!/bin/bash

# This is run right before the "cargo doc" command.
#
# At this point, suibase should be installed, will sanity test while
# getting the version number (which need to be updated in the Cargo.toml).
#
VERSION=$(localnet | head -n 1 | sed 's/.*suibase \(.*\)-.*/\1/g')
if [ -z "$VERSION" ]; then
    echo "Failed to get version number"
    exit 1
fi
sed -i "s/^version = \".*\"$/version = \"$VERSION\"/g" Cargo.toml