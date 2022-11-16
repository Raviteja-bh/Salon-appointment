#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n ~~ Salon Appointment ~~\n"
NUMBERED_LIST=$($PSQL "SELECT service_id, name FROM services")
MAIN_MENU() {
  echo -e "\nHow may I help you?\n"
  echo "$NUMBERED_LIST" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) HAIR_CUT ;;
    2) MASSAGE ;;
    3) HAIR_COLOR ;;
    *) MAIN_MENU "Buddy, that's wrong try again:)" ;;
  esac
}
HAIR_CUT() {
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  #get customer-name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    #Ask for name
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
    # insert new customer into table
    INSERT_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_TIME=$($PSQL "SELECT time FROM appointments WHERE customer_id=$CUSTOMER_ID")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_TIME ]]
  then
    echo -e "\nWhen you would like book an appointment?"
    read SERVICE_TIME
    # insert into appointments table
    APPOINT_TABLE=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  fi
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
MASSAGE() {
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  #get customer-name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    #Ask for name
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
    # insert new customer into table
    INSERT_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_TIME=$($PSQL "SELECT time FROM appointments WHERE customer_id=$CUSTOMER_ID")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_TIME ]]
  then
    echo -e "\nWhen you would like book an appointment?"
    read SERVICE_TIME
    # insert into appointments table
    APPOINT_TABLE=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  fi
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
HAIR_COLOR() {
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  #get customer-name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    #Ask for name
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
    # insert new customer into table
    INSERT_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_TIME=$($PSQL "SELECT time FROM appointments WHERE customer_id=$CUSTOMER_ID")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_TIME ]]
  then
    echo -e "\nWhen you would like book an appointment?"
    read SERVICE_TIME
    # insert into appointments table
    APPOINT_TABLE=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  fi
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
MAIN_MENU
