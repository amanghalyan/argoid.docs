#!/bin/bash
delfilepath=/opt/redash_backup/

#To delete the .sql files older than 5 days
find $delfilepath -mtime +5 -type f -delete
