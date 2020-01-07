#!/usr/bin/env bash

. /app/env.sh
echo "Starting dump of $MYSQL_DATABASE"
cd /backup || exit 1
mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $MYSQL_DATABASE-$(date +%Y-%m-%d).dump
if [ "$COMPRESSION" == "GZ" ]; then
    echo "Compressing $MYSQL_DATABASE"
    gzip $MYSQL_DATABASE-$(date +%Y-%m-%d).dump
fi
echo "Removing dumps older then $DAYS_TO_KEEP days"
find . -name '*.dump' -name '*.dump.gz' -type f -mtime +$DAYS_TO_KEEP -exec rm {} \;
