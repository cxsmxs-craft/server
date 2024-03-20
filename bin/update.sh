# Update the server to the latest paper version
_update() {
    # Set the project name, usually "paper" for PaperMC
    PROJECT="paper"

    # The PaperMC API endpoint for versions
    VERSIONS_URL="https://papermc.io/api/v2/projects/$PROJECT"

    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo "Woah... Seems like is not installed. Onee-chan, please install jq to continue."
        exit 1
    fi

    # Fetch the latest version of PaperMC
    LATEST_VERSION=$(curl -s "$VERSIONS_URL" | jq -r '.versions[-1]')

    # Construct the URL for the latest build number of the latest version
    BUILD_URL="$VERSIONS_URL/versions/$LATEST_VERSION"

    # Fetch the latest build number for the latest version
    LATEST_BUILD=$(curl -s "$BUILD_URL" | jq -r '.builds[-1]')

    # Construct the download URL for the latest PaperMC JAR
    DOWNLOAD_URL="$BUILD_URL/builds/$LATEST_BUILD/downloads/$PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar"

    # Download the latest PaperMC JAR
    echo "Downloading PaperMC$PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar"
    if curl -O "$DOWNLOAD_URL"; then
        echo "Download successful, renaming to paper.jar..."

        echo "Renaming to paper.jar..."
        mv "$PROJECT-$LATEST_VERSION-$LATEST_BUILD.jar" ./bin/paper.jar
    else
        echo "Download failed."
        exit 1
    fi
}