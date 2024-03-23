source "./utils/log.sh"

# Update the server to the latest paper version
_update() {
    PROJECT="paper"
    _log "DEBUG" "The project name is set to $PROJECT."

    VERSIONS_URL="https://papermc.io/api/v2/projects/$PROJECT"
    _log "DEBUG" "The version URL is set to $VERSIONS_URL."

    _log "INFO" "Checking if jq is installed..."
    if ! command -v jq &> /dev/null; then
        _log "ERROR" "Woah... Seems like it's is not installed. Onee-chan, please install jq to continue."
        exit 1
    fi

    LATEST_VERSION=$(curl -s "$VERSIONS_URL" | jq -r '.versions[-1]')
    _log "DEBUG" "The latest version is $LATEST_VERSION."

    BUILD_URL="$VERSIONS_URL/versions/$LATEST_VERSION"
    _log "DEBUG" "The build URL is set to $BUILD_URL."

    LATEST_BUILD=$(curl -s "$BUILD_URL" | jq -r '.builds[-1]')
    _log "DEBUG" "The latest build is $LATEST_BUILD."

    DOWNLOAD_URL="$BUILD_URL/builds/$LATEST_BUILD/downloads/$PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar"
    _log "DEBUG" "The download URL is set to $DOWNLOAD_URL."

    [[ ! -d ./bin ]] && _log "WARN" "Creating bin directory..." && mkdir ./bin

    _log "INFO" "Downloading PaperMC$PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar"

    if curl -O "$DOWNLOAD_URL"; then
        _log "INFO" "Downloaded successfully."

        [[ -f ./bin/paper.jar ]] && _log "WARN" "Deleting old paper.jar..." && rm ./bin/paper.jar

        _log "DEBUG" "Renaming $PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar to paper.jar..."
        mv "$PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar" ./bin/paper.jar

        _log "INFO" "Done!"
    else
        _log "ERROR" "Download failed. Exiting..."
        exit 1
    fi
}