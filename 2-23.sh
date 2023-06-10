#!/bin/bash

# Read from file
# p1: file name
function read_file() {
  cat $1
}

# Print usage
function print_usage() {
  echo -e "Usage:\n\t./2-23.sh [ questions_file_name ] [ answers_file_name ]"
  echo -e "Options:\n\t-h or --help\n\t\tPrint a help message"
}

# Check if file exists
# p1: file name
function check_file() {
  if [ ! -f $1 ]; then
    echo "File $1 does not exist"
    exit 1
  fi
}

# Check if flag -h used
function check_for_flag() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    print_usage
    exit 0
  fi
}

# Main function
function main() {
  check_for_flag $*

  check_file $1 
  check_file $2
  local questions_file=$( read_file $1 )
  local answers_file=$( read_file $2 )

  IFS=$'\n' # Set an env's variable of delimiter to \n
  local array_of_strings=($questions_file) # Get splited-by-strings array using IFS

  for string in ${array_of_strings[@]}; do # For each string in questions file
    IFS=':' # Set the delimiter ":"
    local splited=($string) # Get array of "<id>:<question>:<answers>:<right_answer>"
    local id=${splited[0]} # Map them to variables
    local question=${splited[1]}
    local answers=${splited[2]}
    local right_answer=${splited[3]}

    local string_with_answer=$(echo $answers_file | grep "^$id") # Find a string that starts with question's id (^ stands for begin of a string)
    local chosen_answer=${string_with_answer#* } # Found string has "<id> <answer>" format, because of we set delimiter (IFS) to :,
                                           # so string lost : from itself  

    echo -n "$id $question: " # Flag "-n" means print w\ out new line 

    local RED="\033[31m" # Colors of simbols
    local GREEN="\033[32m"
    local DEFAULT="\033[0m"

    if [ "$chosen_answer" -eq "$right_answer" ]; then # Check if answer is correct
      echo -en "${GREEN}rigth${DEFAULT}"
    else
      echo -en "${RED}false${DEFAULT}"
    fi
    
    echo " ($right_answer)"

  done

  exit 0
}

main $*

