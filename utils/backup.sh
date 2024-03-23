source "./utils/log.sh"

# Backup world progress to git respository
_backup() {
  [[ -d ./backup ]] && _log "WARN" "Detected older backup, deleting it" && rm -rf ./backup

  _log "INFO" "Cloning backup repository"
  git clone git@github.com:cxsmxs-craft/backup.git backup --depth 1

  local folders=(
    "world"
    "world_nether"
    "world_the_end"
  )

  _log "INFO" "Deleting old backups inside the repository"
  for file in "${folders[@]}"; do
    _log "DEBUG" "Deleting $file"
    rm -rf "./backup/$file"
  done

  _log "INFO" "Copying world files to the repository"
  for file in "${folders[@]}"; do
    _log "DEBUG" "Copying $file"
    cp -r "./server/$file" backup
  done

  _log "INFO" "Checking for any changes"
  cd ./backup || exit 1

  _log "INFO" "Adding changes to git"
  git add .

  [[ -z $(git status -uno --porcelain) ]] \
    && _log "INFO" "No updates detected, no need for push!" \
    && cd .. \
    && _log "DEBUG" "Now I'm at $(pwd)" \
    && rm -rf backup \
    && _log "DEBUG" "Cleaned up temporary files that was generated!" \
    && exit 0;

  _log "INFO" "Committing changes..."
  git commit -m "update world $(date -u)"

  _log "INFO" "Pushing changes to the repository"
  git push origin main --force

  _log "DEBUG" "I'm at $(pwd)"

  cd ..
  _log "DEBUG" "Now I'm at $(pwd)"

  _log "INFO" "Cleaning up temporary files..."
  rm -rf backup
}