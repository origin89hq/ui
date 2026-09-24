#!/usr/bin/env bash
# Accepts a Swift package version only when it is plain X.Y.Z, untagged, and above every Swift tag.
set -euo pipefail
version="${1:?usage: check-swift-version.sh X.Y.Z}"
semver='^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$'
[[ "$version" =~ $semver ]] || { echo "Swift versions are plain X.Y.Z, got '$version'" >&2; exit 1; }
latest="$(git tag --list | grep -E "$semver" | sort -t. -k1,1n -k2,2n -k3,3n | tail -n 1 || true)"
if [[ -n "$latest" ]]; then
  highest="$(printf '%s\n%s\n' "$latest" "$version" | sort -t. -k1,1n -k2,2n -k3,3n | tail -n 1)"
  [[ "$version" != "$latest" && "$highest" == "$version" ]] || { echo "Swift version $version must be above $latest" >&2; exit 1; }
fi
echo "Releasing Swift package $version (previous: ${latest:-none})"
