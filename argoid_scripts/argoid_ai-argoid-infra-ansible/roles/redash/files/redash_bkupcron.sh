#!/bin/bash
#created by vasu
##created on 2021-09-06 ist
##last modified on 2021-09-22 ist

date=$(date '+%Y-%m-%d_%H:%M:%S')
pg_dump_backup_dir=/opt/redash_backup/pg_dump/pg_dump_$date.sql
redash_secret_key_dir=/opt/redash_backup/redash_secret_key/redash_secret_key_$date
redash_container={{ redash_container }}
azure_backup={{ azure_backup }}
docker_container_secret=redash_server_1
docker_container_postgres=redash_postgres_1
logrotate_script=/opt/logrotate_redash.sh
redash_secret_key= {{ redash_secret_key }}

##"Backup the postgres database"
docker exec $docker_container_postgres  pg_dump -U postgres postgres >> $pg_dump_backup_dir

## "Backup redash secret key"
docker inspect $docker_container_secret | grep $redash_secret_key >> $redash_secret_key_dir

## "azure syncing with azure blob"
az storage azcopy blob sync --container $redash_container  -s $azure_backup

## "calling the log rotation script"
bash "$logrotate_script"
