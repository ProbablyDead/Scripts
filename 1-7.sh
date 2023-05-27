#!/bin/bash

function create_user_password() {
  echo $( pwgen )
}

function write_to_file() {
  echo $2 >> $1
}

function clear_file() {
  local COLUMN_NAMES="User,Password"
   echo $COLUMN_NAMES > $1
}

function check_parameters() {
  if [ $1 -gt $2 ]; then
    echo "End index must be greater then start one"
    exit 1
  fi
}

function main() {
  local START_IDX=$1
  local END_IDX=$2

  check_parameters $START_IDX $END_IDX

  local USER_NAME_PREFIX=$( cat - )
  local FILE_NAME="users.csv"

  clear_file $FILE_NAME
  
  for IDX in $( seq $START_IDX $END_IDX ); do
    write_to_file $FILE_NAME "${USER_NAME_PREFIX}_$IDX,$( create_user_password )"
  done
}

main $*
