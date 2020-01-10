#!/usr/bin/env bash

. /app/env.sh
cd /backup || exit 1
DUMP_FILE=$MYSQL_DATABASE\_$(date '+%Y-%m-%d_%H-%M').dump
echo "Dumping database $MYSQL_DATABASE to file $DUMP_FILE"
mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $DUMP_FILE
if [ "$COMPRESSION" == "GZ" ]; then
    echo "Compressing $DUMP_FILE"
    gzip "$DUMP_FILE"
fi
echo "Removing dumps older then $DAYS_TO_KEEP days"
find . -type f \( -name '*.dump' -o -name '*.dump.gz' \) -mtime +$DAYS_TO_KEEP -exec rm {} \;
