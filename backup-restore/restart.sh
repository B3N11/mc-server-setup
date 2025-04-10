# Check for container name
if [ -z "$1" ]; then
	echo "Container name required"
	exit 1
fi

CONT=$1

docker restart $CONT && docker logs $CONT --follow
