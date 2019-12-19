#!/bin/bash

if [ "$1" == "u" ]; then
  echo "starting portainer..."
  docker-compose up -d portainer

  echo "starting mysql..."
  docker-compose up -d mysql

  mysqlStatus="null"
  while [ "$mysqlStatus" != "healthy" ]; do
    mysqlStatus="$(docker inspect --format "{{ .State.Health.Status }}" mysql_database)"
    echo "mysql state : "$mysqlStatus"..."
    sleep 5
  done

  echo "starting django..."
  docker-compose up -d django

elif [ "$1" == "d" ]; then
  docker-compose stop

elif [ "$1" == "help" ]; then
  echo "--- manuel d'utilisation ---"
  echo "./run.sh u -- start the server"
  echo "./run.sh d -- stop the server"

else
  echo "commande inconnue"

fi