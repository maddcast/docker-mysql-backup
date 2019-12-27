#!/usr/bin/env bash

declare -a REQUIRED_VARS=("MYSQL_HOST" "MYSQL_DATABASE" "MYSQL_USER" "MYSQL_PASSWORD" "DAYS_TO_KEEP" "COMPRESSION")

IFS=$'\n' ENV_STRINGS=($(printenv))

for var_name in "${REQUIRED_VARS[@]}"
do
    FIND=false
    for env_string in "${ENV_STRINGS[@]}"
    do
        if [[ "$env_string" == "$var_name="* ]]; then
            echo "export $env_string" >> /app/env.sh
            FIND=true
        fi
    done
    if [ "$FIND" == "false" ]; then
        echo "env var $var_name not found"
        exit 1
    fi
done
