#!/bin/bash

function print_usage() {
  local MESSAGE=$'Usage: [ command (e.g. echo "user name") ] | ./1-7.sh [ start_usr_id ] [ end_usr_id ] [ (optional, def=10) pass_len ]\n
Options supported by 1_7:
\t -h or --help
\t\tPrint a help message'
  echo "$MESSAGE"
}

function create_user_password() {
  echo $( pwgen $1 1)
}

function write_to_file() {
  echo $2 >> $1
}

function clear_file() {
  local COLUMN_NAMES="User,Password"
  echo $COLUMN_NAMES > $1
}

function check_parameters() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    print_usage
    exit 0
  fi

  if [ $1 -gt $2 ]; then
    echo "End index must be greater then start one"
    exit 1
  fi

  if [ ! -z $3 ]; then
    PASSWORD_LENGTH=$3
  fi
}

function main() {
  local START_IDX=$1
  local END_IDX=$2
  PASSWORD_LENGTH=10

  check_parameters $*

  local USER_NAME_PREFIX=$( cat - )
  local FILE_NAME="users.csv"

  clear_file $FILE_NAME
  
  for IDX in $( seq $START_IDX $END_IDX ); do
    write_to_file $FILE_NAME "${USER_NAME_PREFIX}_$IDX,$( create_user_password $PASSWORD_LENGTH)"
  done

  exit 0
}

main $*
