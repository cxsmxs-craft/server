# Launch the server peacefully
_launch() {
    # Check if paper.jar exists
    if [[ ! -f "../bin/paper.jar" ]]; then
        echo "Ooh, paper.jar where? Maybe you forgor to run update command? :3"
        exit 1
    fi

    # Check if function is called with arguments
    # If so, execute the command with arguments
    # Otherwise, start the server with default arguments
    if [[ $# -gt 0 ]]; then
        echo "Starting server with arguments: $*"
        /usr/bin/env java "$@" -jar ../bin/paper.jar --nogui
    else
        echo "Starting server with default arguments"
        ../bin/minegram
    fi
}