FROM mcr.microsoft.com/mssql-tools:latest

ENV \
    MSSQL_DB_SERVER="mssql" \
    MSSQL_DB_USER="sa" \
    MSSQL_DB_PASSWORD="" \
    MSSQL_DB_NAMES="" \
    MYSQL_DB_SERVER="mysql" \
    MYSQL_DB_USER="root" \
    MYSQL_DB_PASSWORD="" \
    MYSQL_DB_NAMES="" \
    CRON_SCHEDULE="0 1 * * sun" \
    BACKUP_CLEANUP=false \
    BACKUP_AGE=7 \
    SKIP_BACKUP_LOG=false \
    PACK="" \
    ZIP_PASSWORD="" \
    PUSH_REMOTE_MODE="" \
    SMTP_HOST="" \
    SMTP_PORT="" \
    SMTP_AUTH="on" \
    SMTP_USER="" \
    SMTP_PASS="" \
    SMTP_FROM="" \
    SMTP_TLS="on" \
    MAIL_TO=""    

RUN apt-get update && \
    apt-get install -y cron zip msmtp msmtp-mta mailutils mysql-client && \
    rm -rf /var/cache/apk/*

COPY mssql-backup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mssql-backup.sh

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
