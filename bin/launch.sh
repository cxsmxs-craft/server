# Launch the server peacefully
_launch() {
    # Enter the server directory
    cd "$(dirname "$0")/server" || exit 1

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
        java -Xms12G -Xmx12G -XX:ConcGCThreads=8 -jar ../bin/paper.jar --nogui
        # /usr/bin/java -Xms12G -Xmx12G -XX:ConcGCThreads=8 -jar /home/cubach/paper-1.20.2-260.jar --nogui
        # /usr/bin/java -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=7 -Xms10G -Xmx10G -jar /home/cubach/paper-1.20.1-196.jar --nogui
    fi
}