#!/bin/bash


PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"



# If input is atomic number
ATOMIC_NUMBER_FUNC () {
  ELEMENT_SEARCH_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$ATOMIC_NUMBER")

  if [[ -z $ELEMENT_SEARCH_RESULT ]]
   then
     echo "I could not find that element in the database."

    else

    ELEMENT_INFO=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")

    echo $ELEMENT_INFO | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR SYMBOL BAR NAME BAR TYPE 
    do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    
done
   fi
  
}


# if input is symbol or name 
NAME_OR_SYMBOL_FUNC(){
  ELEMENT_SEARCH=$($PSQL "SELECT * FROM elements WHERE symbol='$NAME_OR_SYMBOL' OR name='$NAME_OR_SYMBOL'")
  
   if [[ -z $ELEMENT_SEARCH ]]
    then
      echo "I could not find that element in the database."

    else
    ELEMENT_INFO=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$NAME_OR_SYMBOL' OR symbol='$NAME_OR_SYMBOL'")
    
     echo $ELEMENT_INFO | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR SYMBOL BAR NAME BAR TYPE 
    do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    
done
   
   fi

}







if [[ -z $1 ]]
 then
 echo -e "Please provide an element as an argument."

else
  # if input is atomic number
  if [[ $1 =~ ^[0-9]+$ ]]
   then
   ATOMIC_NUMBER=$1
   ATOMIC_NUMBER_FUNC

   else 
   NAME_OR_SYMBOL=$1
   

   NAME_OR_SYMBOL_FUNC


  fi

fi

