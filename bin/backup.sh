# Backup world progress to git respository
_backup() {
  # Clone the repository
  git clone git@github.com:cxsmxs-craft/backup.git backup

  # Delete old backups
  rm -rf ./backup/world
  rm -rf ./backup/world_nether
  rm -rf ./backup/world_the_end

  # Copy the world files
  cp -r ./server/world backup
  cp -r ./server/world_nether backup
  cp -r ./server/world_the_end backup

  # Check if there are any changes
  cd ./backup || exit 1
  git add .
  [[ -z $(git status -uno --porcelain) ]] && echo "No updates detected, no need for push" && exit 0;
  git commit -m "update world $(date -u)"
  git push origin main --force
  cd ..

  # Cleaning up
  rm -rf backup
}