source "./utils/log.sh"
source "./utils/update.sh"

# Setup the server from scratch
_setup() {
  _log "INFO" "Getting latest version of PaperMC..."
  _update

  _log "INFO" "Checking if plugins are installed..."
  # shellcheck disable=SC2012
  if [[ $(ls -1 ./server/plugins/*.jar | wc -l) -eq 0 ]]; then
    _log "INFO" "Downloading plugins listed in .plugins..."
    while IFS= read -r line; do
      _log "INFO" "Downloading $line..."
      curl -L "$line" -o "./server/plugins/$(basename $line)" || _log "ERROR" "Failed to download $line."
    done < ./server/plugins/.plugins
  else
    _log "INFO" "Plugins are already downloaded. Skipping..."
  fi

  # If there is no eula.txt, create one or write content if it's empty
  if [[ ! -f ./server/eula.txt ]]; then
    _log "INFO" "Creating eula.txt..."
    echo "eula=true" > ./server/eula.txt
  else
    _log "INFO" "eula.txt already exists. Skipping..."
  fi
}