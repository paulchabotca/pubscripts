#!/bin/bash
ER="$1"
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

TABLES=$($MYSQL -u $MUSER -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )

echo -n Enter Password for $MUSER:
read -s MPASS

for t in $TABLES
do
    echo "Deleting $t table from $MDB database..."
    $MYSQL -u $MUSER -p$MPASS $MDB -e "drop table $t"
done
