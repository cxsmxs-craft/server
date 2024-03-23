# Logging to the console made better
_log() {
  # The level of message
  # Possible values: INFO, WARN, ERROR, DEBUG, HELP
  local level=$1

  # The message to be displayed
  # Possible values: Any string
  local message=$2

  # The timestamp of the log
  # Possible values: Automatically generated
  # shellcheck disable=SC2155
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")

  # The colored level of the log
  # Possible values: Automatically generated
  local colored_level

  # Apply color to level
  case $level in
    "INFO")
      colored_level="\e[32m$level\e[0m"
      ;;
    "WARN")
      colored_level="\e[33m$level\e[0m"
      ;;
    "ERROR")
      colored_level="\e[31m$level\e[0m"
      ;;
    "DEBUG")
      colored_level="\e[34m$level\e[0m"
      if [[ -z $DEBUG ]]; then
        return
      fi
      ;;
  esac

  # If level is HELP, just print colored level
  [[ $level == "HELP" ]] && echo -e "\e[33m$message\e[0m" && return

  # Print the log message with colored level
  echo -e "[$timestamp] [$colored_level] $message"
}