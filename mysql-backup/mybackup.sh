#!/usr/bin/env bash

. /app/env.sh
mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > /backup/$MYSQL_DATABASE-$(date +%Y-%m-%d).dump
if [ "$COMPESSION" == "GZ" ]; then
  gzip /backup/$MYSQL_DATABASE-$(date +%Y-%m-%d).dump
fi
find /backup -name '*.dump' -name '*.dump.gz' -type f -mtime +$DAYS_TO_KEEP -exec rm {} \;
