#!/bin/bash

# Выводит сообщение об использовании программы
function echo_usage() {
  local usage=$'Usage:\n\t./3-24.sh [ number ]\nOptions:\n\t-h or --help\n\t\thelp message'
  echo "$usage"
}

# Проверяет введенный параметр, если параметр не являетс числом или он меньше 1 - выходим
function check_number() {
  local number=$1
  local reg='^[0-9]+$'

  if ! [[ $number =~ $reg ]]; then
    echo "Value must be an integer!"
    exit 1
  fi

  if [ $1 -lt 1 ]; then
    echo "Value must be greater than 0!"
    exit 1
  fi
}

# Проверяет параметры. Если первый -h или --help, то выходим usage и выходим, иначе проверяем на корректность введенное число
function check_parameters() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo_usage
    exit 0
  fi

  check_number $1
}

# Проверяет число на четность
function get_number_parity() {
  local number=$1
  if [[ $(( $number % 2 )) -eq 0 ]]; then
    echo true
    return
  fi
  echo false
}

# Получает следующее чило последовательности 
function calculate_next_number() {
  local number=$1
  
  if [ $( get_number_parity $number ) = "true" ]; then
    echo $(( $number / 2 ))
  else
    echo $(( $number * 3 +1 ))
  fi
}

# Выводит на экран строку <номер>: <число>
function print_number() {
  echo "$1: $2"
}

# Функция вычисления последовательности
function count_sequence() {
  local number=$1
  local counter=0
  print_number $counter $number

  while [ ! $number -eq 1 ]; do
    number=$( calculate_next_number $number ) 
    counter=$(( $counter + 1 ))
    print_number $counter $number
  done
}

# Main
function main() {
  check_parameters $*

  count_sequence $1

  exit 0
}

main $*

