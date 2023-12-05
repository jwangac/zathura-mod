#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# Apply the patch file
cat *.patch | patch -f -p1 -d src/

# Check if the patch was successful
if [ $? -eq 0 ]; then
    echo "Patch applied successfully."
    exit 0
else
    echo "Patch failed to apply."
    exit 1
fi
