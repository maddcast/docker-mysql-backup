FROM ubuntu:18.04

# Setup time zone
ENV TZ "Europe/Moscow"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup soft
RUN apt-get update && apt-get install -y mariadb-client cron tzdata dos2unix

VOLUME /backup

WORKDIR /app

COPY mybackup.sh /app
COPY prepare.sh /app

# Convert scripts from windows to unix
RUN chmod +x /app/*.sh
RUN dos2unix /app/*

# Create mybackup user
RUN useradd -c 'MySQL backup user' -m -d /home/mybackup -s /bin/false mybackup
RUN chown -R mybackup:mybackup /app

# Start cron service
CMD /app/prepare.sh && cron -f
