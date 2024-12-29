##created by vasu
##created on 28-05-2021
##modified on 07-07-2021
#!/bin/bash
filepath=/home/airflow/airflow/logs/
delfilepath=/home/airflow/airflow/logs/
deldirpath=/home/airflow/airflow/logs/

#To gzip the files older than 3 days
for f in $(find $filepath -name "*.log" -mtime +{{ log_to_zip_no_of_days }} -type f) ;
 do
  # filename=`echo $f | awk -F '/' '{print $NF}'`;
  gzip  $f
  echo "$f"
 done

#To delete the zipped files older than 7 days
find $delfilepath -name "*.gz" -mtime +{{ zip_to_delete_no_of_days }} -type f -delete

#To delete the directories older than 9 days
#find $deldirpath -mtime +9 -type d -empty -delete

