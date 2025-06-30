# Changelog

## v0.1.0

Initial effort.

Supports the minimal parsing required to extract relevant information from `meta.conf` as used in the `fwup` tool. It will not interpolate variables or any other exciting bits. It will not perform includes.

## v0.1.1

Fix weird return format for `Confuse.Fwup.get_delta_files/1`.

## v0.1.2

Add function to get fwup feature information and figure out minimum required version and
version for delta updates.

## v0.1.3

Fix bug where `Confuse.Fwup.get_features/1` could return a string in `delta_fwup_version`.
