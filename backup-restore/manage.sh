#! /bin/bash

# Check if container name is provided
if [ -z "$1" ]; then
	echo "Container name required"
	exit 1
fi

# Give a name to the session
CONT=$1
SESH="server-manage-(${CONT})"

# Check already existing session and create new if there isnt one
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -d -s $SESH
fi

# Select first window and ensure one pane
tmux select-window -t $SESH:0
tmux kill-pane -a -t $SESH:0.0

# Split the original horizontally (creates pane 1) and attach to server
tmux split-window -h -t ${SESH}:0.0
tmux send-keys -t ${SESH}:0.1 "docker attach ${CONT}" C-m

# Split pane 0 vertically (creates pane 2) and enter container
tmux split-window -v -t ${SESH}:0.0
tmux send-keys -t ${SESH}:0.1 "docker exec -it ${CONT} bash" C-m

# Return focus to original pane (pane 0)
tmux select-pane -t ${SESSION_NAME}:0.0

# Attach to session
tmux attach-session -t $SESH
