#!/usr/bin/env bash

# Check required environment variables and save them to file for cron usage

declare -a REQUIRED_VARS=("MYSQL_HOST" "MYSQL_DATABASE" "MYSQL_USER" "MYSQL_PASSWORD" "DAYS_TO_KEEP" "COMPRESSION" "CRON_EXPRESSION")

IFS=$'\n' ENV_STRINGS=($(printenv))

for var_name in "${REQUIRED_VARS[@]}"
do
    FIND=false
    for env_string in "${ENV_STRINGS[@]}"
    do
        if [[ "$env_string" == "$var_name="* ]]; then
            echo "export \"$env_string\"" >> /app/env.sh
            FIND=true
        fi
    done
    if [ "$FIND" == "false" ]; then
        echo "Environment variable $var_name not found"
        exit 1
    fi
done

# Create cron job and apply it for user mybackup

echo "$CRON_EXPRESSION /app/mybackup.sh" | crontab -u mybackup -
echo "Created crontab"
echo "$CRON_EXPRESSION /app/mybackup.sh"
