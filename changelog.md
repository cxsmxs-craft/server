## [19/04/2024]

**After a heavy fuck up, we decided to take some actions and recover older state of our server:**
- Adding minegram for auth / telegram notification
- 

## [14/03/2024]

**Here are the things that I changed on server:**
- Rewrote start.sh to launcher.sh
- The launcher.sh script supports multiple scripts. With the help of script, now you can:
    - Run with default or custom passed parameters
    - Update the paper server file
    - Clean up caches and garbage
    - Aaah... Show a handy helper message?
- Changed NBT records inside all 3 dimensions [Property Difficulty to 3 (Hard)]
- Deleted cached files that can be regenerated on run
- A file namely .clean to keep list of cleanable files 
- Changed log & UI messages on .yml files including:
    - bukkit.yml
    - permissions.yml
- Changed motd and server-icon to cxsmxs craft theme
- Fucked around with configs and found out
- Added a calming music for you to listen while starting server _(java sucks, life is too short)_