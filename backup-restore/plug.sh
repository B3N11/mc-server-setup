#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
  echo "Container name needed"
  exit 1
fi

# Get the required input (first argument)
CONT=$1

# Process the optional inputs (remaining arguments)
echo "ADDING PLUGINS..."
if [ $# -gt 1 ]; then
  shift  # Remove the first argument (already assigned to required_input)
  for args in "$@"; do
filename=$(basename -- $args)
echo "Plugging in $filename..."
docker cp $filename $CONT:/data/plugins/
  done
else
  echo "No plugins were added."
fi

echo "DONE!"
