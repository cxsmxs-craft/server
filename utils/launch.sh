source "./utils/log.sh"

# Launch the server peacefully
_launch() {
    _log "DEBUG" "Entering the server directory..."
    cd "$(dirname "$0")/server" || exit 1

    _log "DEBUG" "Checking if paper.jar exists..."
    if [[ ! -f "../bin/paper.jar" ]]; then
        _log "ERROR" "Ooh, paper.jar where? Maybe you forgor to run update command? :3"
        exit 1
    fi

    _log "DEBUG" "Checking if theres any arguments..."
    if [[ $# -gt 0 ]]; then
        _log "INFO" "Starting server with arguments: $*"
        /usr/bin/env java "$@" -jar ../bin/paper.jar --nogui
    else
        _log "INFO" "Starting server with default arguments"
        java -Xms12G -Xmx12G -XX:ConcGCThreads=8 -jar ../bin/paper.jar --nogui
        # /usr/bin/java -Xms12G -Xmx12G -XX:ConcGCThreads=8 -jar /home/cubach/paper-1.20.2-260.jar --nogui
        # /usr/bin/java -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=7 -Xms10G -Xmx10G -jar /home/cubach/paper-1.20.1-196.jar --nogui
    fi
}