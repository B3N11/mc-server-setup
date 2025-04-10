# Check if argument is provided
if [ -z "$1" ]; then
	echo "Tar file required"
	exit 1
fi
if [ -z "$2" ]; then
	echo "Container name required"
	exit 1
fi

# Store argument
filename=$(basename -- "$1")
container=$2

# Remove world directories from container
printf "REMOVING PREVIOUS WORLDS..."
docker exec ${container} rm -r world world_nether world_the_end plugins server.properties
echo "DONE!"

# Copy and extract tar file
printf "COPYING AND EXTRACTING FILE..."
docker cp ${filename} ${container}:/data/
docker exec ${container} tar -xf ${filename}
echo "DONE!"

# Cleanup
printf "CLEANING UP..."
docker exec ${container} rm ${filename}
echo "DONE!"

echo "RESTORE OPERATION SUCCESSFULL!"
