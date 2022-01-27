#!/bin/bash

export PGPASSWORD='postgres'
TODAY=$(date +"%Y-%m-%d")

psql -c "\copy (select * from match) To '/home/io/scraper-logs/match.csv' delimiter ';' csv HEADER" -h localhost -U postgres postgres
psql -c "\copy (select * from task_execution) To '/home/io/scraper-logs/task_execution.csv' delimiter ';' csv HEADER" -h localhost -U postgres postgres

cd /home/io/scraper-logs/
tar -cvzf logs_$TODAY.tar.gz *.log
rm *.log
cd -

cd /home/io/scraper-logs/
tar -cvzf tables_$TODAY.tar.gz *.csv
rm *.csv
cd -

cd /home/io/gcloud_home/gcp-app-test/exchange/dump
zip -r /home/io/scraper-logs/dump_$TODAY.zip *
cd -

gdrive upload /home/io/scraper-logs/logs_$TODAY.tar.gz
gdrive upload /home/io/scraper-logs/tables_$TODAY.tar.gz
gdrive upload /home/io/scraper-logs/dump_$TODAY.zip 





