#!/bin/bash

set -euo pipefail

# This script is a tool for applying patches to the upstream repository.

# Directory containing the patch files
PATCH_DIR="../patches"

# Check if the patch directory exists
if [[ ! -d "$PATCH_DIR" ]]; then
  echo "Error: Directory '$PATCH_DIR' does not exist."
  exit 1
fi

# Iterate over all patch files in the directory
for patch in "$PATCH_DIR"/*.patch; do
  if [[ -f "$patch" ]]; then
    echo "Applying patch: $patch"
    git am -3 "$patch" || {
      echo "Failed to apply patch: $patch"
      exit 1
    }
  else
    echo "No patch files found in '$PATCH_DIR'."
    exit 0
  fi
done

echo "All patches applied successfully."