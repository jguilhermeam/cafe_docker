#!/bin/bash


#ajuste permissoes
chmod 600 /etc/ldap/slapd.conf /var/lib/ldap/*

#check if need to run popula.sh
NUM_FILES=$(ls /var/lib/ldap | wc -l)
if [ "$NUM_FILES" -eq 1 ]; then
   echo "[INFO] /var/lib/ldap has only DB_CONFIG... running popula.sh"
   bash /tmp/popula.sh
fi

if [[ -f "/tmp/popula.sh" ]]; then
    rm /tmp/popula.sh
fi

# Start the first process
service slapd start
status=$?
if [ $status -ne 0 ]; then
  echo "[ERROR] Failed to start slapd: $status"
  exit $status
fi


while sleep 60; do
  ps aux | grep slapd |grep -q -v grep
  PROCESS_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_STATUS -ne 0 ]; then
    echo "[WARNING] slapd process is dead. exiting..."
    exit 1
  fi
done
