#!/bin/bash

set -e

BACKUP_FOLDER="backup"
MARIADB_USER="tryhard"
MARIADB_PASSWORD="1234"
DB_NAME="mariondb"
DB_IP="10.0.0.30"
TABLE_NAME="mariondb"

################################################################################
###                                  MAIN                                    ###
################################################################################

# Save file name format: 

if [ ! -d $BACKUP_FOLDER ]; then
    mkdir $BACKUP_FOLDER
fi

while (true); do
    mariadb-admin ping -h "$DB_IP" -u "$MARIADB_USER" -p"$MARIADB_PASSWORD"
    if [ "$?" -eq 0 ]; then
        mariadb-dump -h "$DB_IP" -u "$MARIADB_USER" -p"$MARIADB_PASSWORD" "$DB_NAME" > "$BACKUP_FOLDER"/"$DB_NAME".sql
        echo "Backup saved to $BACKUP_FOLDER/$DB_NAME.sql"
    fi
    sleep 300
done