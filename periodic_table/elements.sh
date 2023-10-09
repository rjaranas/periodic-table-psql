#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  FIND_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
  if [[ -z $FIND_ATOMIC_NUMBER ]]
  then 
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      FIND_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
      if [[ -z $FIND_ATOMIC_NUMBER ]]
      then
      echo -e "I could not find that element in the database."
      else
      FIND_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $FIND_ATOMIC_NUMBER")
      FIND_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $FIND_ATOMIC_NUMBER")
      FIND_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $FIND_ATOMIC_NUMBER")
      FIND_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $FIND_ATOMIC_NUMBER")
      FIND_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $FIND_ATOMIC_NUMBER")
      FIND_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $FIND_ATOMIC_NUMBER")
      FIND_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $FIND_TYPE_ID")
      echo "The element with atomic number $(echo $FIND_ATOMIC_NUMBER | sed -r 's/^ *| *$//g') is $(echo $FIND_ELEMENT_NAME | sed -r 's/^ *| *$//g') ($(echo $FIND_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $FIND_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $FIND_ATOMIC_MASS | sed -r 's/^ *| *$//g') amu. $(echo $FIND_ELEMENT_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $FIND_MP | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $FIND_BP | sed -r 's/^ *| *$//g') celsius."
      fi
    else
      echo -e "I could not find that element in the database."
    fi
  else
    FIND_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$FIND_ATOMIC_NUMBER'")
    FIND_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$FIND_ATOMIC_NUMBER'")
    FIND_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$FIND_ATOMIC_NUMBER'")
    FIND_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$FIND_ATOMIC_NUMBER'")
    FIND_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$FIND_ATOMIC_NUMBER'")
    FIND_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = '$FIND_ATOMIC_NUMBER'")
    FIND_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $FIND_TYPE_ID")
    echo "The element with atomic number $(echo $FIND_ATOMIC_NUMBER | sed -r 's/^ *| *$//g') is $(echo $FIND_ELEMENT_NAME | sed -r 's/^ *| *$//g') ($(echo $FIND_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $FIND_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $FIND_ATOMIC_MASS | sed -r 's/^ *| *$//g') amu. $(echo $FIND_ELEMENT_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $FIND_MP | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $FIND_BP | sed -r 's/^ *| *$//g') celsius."
  fi
fi
