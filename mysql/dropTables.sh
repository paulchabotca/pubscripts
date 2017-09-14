# Drop Tables Script
# Removes all tables from a mysql database without dropping the database
# Paul Chabot - www.paulchabot.ca
# Original script from https://www.cyberciti.biz/faq/how-do-i-empty-mysql-database/

#!/bin/bash
MUSER="$1"
MDB="$2"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)

if [ $# -ne 2 ]
then
    echo "Usage: $0 {MySQL-User-Name} {MySQL-Database-Name}"
    echo "Drops all tables from a MySQL"
    exit 1
fi
# Ask for password, keeps it off the command line and out of the bash history file.
echo -n Enter Password for $MUSER:
read -s MPASS

TABLES=$($MYSQL -u $MUSER -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )


for t in $TABLES
do
    echo "Deleting $t table from $MDB database..."
    $MYSQL -u $MUSER -p$MPASS $MDB -e "drop table $t"
done
