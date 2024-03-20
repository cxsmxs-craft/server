# Clean up server from unnecessary files and directories
_clean() {
    # Enter the server directory
    cd "$(dirname "$0")/server" || exit 1

    # Define the .clean file
    CLEAN_FILE=".clean"

    # Check if the .clean file exists
    if [[ ! -f "$CLEAN_FILE" ]]; then
    echo "The file $CLEAN_FILE does not exist."
    exit 1
    fi

    # Read the .clean file line by line
    while IFS= read -r line; do
        # Check if the line is empty or if it's a comment
        if [[ -z "$line" || $line == \#* ]]; then
            continue
        fi

        # Check if the file or directory exists before attempting to delete
        if [[ -e "$line" || -d "$line" ]]; then
            # Attempt to delete the file or directory
            rm -rf "$line"
            echo "Deleted: $line"
        else
            echo "File or directory does not exist: $line"
        fi
    done < "$CLEAN_FILE"

    echo "Cleanup complete."
}