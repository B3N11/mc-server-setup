#!/bin/bash

# Check if container name is provided
if [ -z "$1" ]; then
	echo "Container name required"
	exit 1
fi

echo "Starting..."
# Define variables
container=$1
timestamp=$(date "+%Y_%m_%d_%H%M")
filename="backup_(${container})_${timestamp}.tar"

printf "COMPRESSING WORLD DIRECTORIES..."
# Create tar file in container
docker exec ${container} tar -cf ${filename} world world_nether world_the_end
echo "DONE!"

printf "COPYING TO HOST..."
# Copy tar file to host
cd backup
docker cp ${container}:/data/${filename} ${filename} > /dev/null
cd ..
echo "DONE!"

printf "CLEANING UP..."
# Cleanup
docker exec ${container} rm ${filename}
echo "DONE!"

echo "BACKUP OPERATION SUCCESSFULL!"
