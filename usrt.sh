#!/bin/bash

# Print options of script
function print_options() {
  local message=$'Options supported by usrt:
\t -h or --help
\t\tprint a help message'
  echo "$message"
}

# Print usage
function print_usage() {
  local message=$'Usage: [ (optional) command (e.g. echo "user name") | ] ./usrt.sh (./1-7.sh) [ start_usr_id ] [ end_usr_id ] [ (optional, def=10) pass_len ]\n'
  echo "$message"
  print_options
}

# Return one password 
#   param 1: password length
function create_user_password() {
  echo $( pwgen $1 1)
}

# Write string to file
#   param 1: file name
#   param 2: string to write
function write_to_file() {
  echo $2 >> $1
}

# Clear file and write titles of columns 
#   param 1: file name
function renew_file() {
  local column_names="User,Password"
  echo $column_names > $1
}

# Check inputed parameters
function check_parameters() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    print_usage
    exit 0
  fi

  if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Wrong parameters count
    "
    print_usage
    exit 1
  fi

  if [ $1 -gt $2 ]; then
    echo "End index must be greater then start one
    "
    print_usage
    exit 1
  fi

  # If third parameter is set, change it, else leave it default
  if [ ! -z $3 ]; then 
    password_length=$3
  fi
}

# Main function
function main() {
  local start_idx=$1
  local end_idx=$2
  # local user_name_prefix=$( less <&0 2> /dev/null ) # "&0" - standart input is a file w/ descriptor zero, "2> /dev/null" - skip printing errors
  read user_name_prefix
  password_length=10

  check_parameters $*

  local file_name="users.csv"

  renew_file $file_name
  
  for idx in $( seq $start_idx $end_idx ); do
    write_to_file $file_name "${user_name_prefix}_$idx,$( create_user_password $password_length )"
  done

  exit 0
}

main $*

