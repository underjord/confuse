# Changelog

## v0.3.1

Do not error out on validating a delta where a source file is missing in the target. This is valid. It can just have been removed.

## v0.3.0

Replace nimble_parsec with yecc and leex to avoid tearing hair out while debugging.

## v0.2.1

Fix handling of escaped double quotes in strings.

## v0.2.0

Add `Confuse.Fwup` functions for processing config that has already been read from file. This allows doing things more efficiently when making multiple calls and so on.

## v0.1.5

Fix issues where the `Confuse.Fwup` module was not interpreting `meta.conf` style definitions.

## v0.1.4

Add function for checking delta safety between two fwup configs.

## v0.1.3

Fix bug where `Confuse.Fwup.get_features/1` could return a string in `delta_fwup_version`.

## v0.1.2

Add function to get fwup feature information and figure out minimum required version and
version for delta updates.

## v0.1.1

Fix weird return format for `Confuse.Fwup.get_delta_files/1`.

## v0.1.0

Initial effort.

Supports the minimal parsing required to extract relevant information from `meta.conf` as used in the `fwup` tool. It will not interpolate variables or any other exciting bits. It will not perform includes.
