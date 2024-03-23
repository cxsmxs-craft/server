source "./utils/log.sh"

# Clean up server from unnecessary files and directories
_clean() {
    _log "INFO" "Entering server directory"
    cd "$(dirname "$0")/server" || exit 1

    CLEAN_FILE=".clean"
    _log "DEBUG" "The default cleanup file list is: $CLEAN_FILE"

    _log "DEBUG" "Checking if .clean file exists"
    if [[ ! -f "$CLEAN_FILE" ]]; then
      _log "ERROR" "The file $CLEAN_FILE does not exist."
      exit 1
    fi

    _log "DEBUG" "Reading .clean file line by line"
    while IFS= read -r line; do
        _log "DEBUG" "Checking if the line is empty or a comment"
        if [[ -z "$line" || $line == \#* ]]; then
            _log "DEBUG" "Empty line or comment, skipping..."
            continue
        fi

        _log "DEBUG" "Checking if the file or directory exists"
        if [[ -e "$line" || -d "$line" ]]; then
            rm -rf "$line"
            _log "INFO" "Deleted: $line"
        else
            _log "WARN" "File or directory does not exist: $line"
        fi
    done < "$CLEAN_FILE"

    _log "INFO" "Cleaning up has been completed"
}