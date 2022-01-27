#!/bin/bash

cd /home/io/gcloud_home/gcp-app-test/bet-scheduler/target
nohup java -jar bet-scheduler-0.0.1-SNAPSHOT.jar > /home/io/scraper-logs/run.log 2>&1 &
echo $$ > scheduler.pid
cd -

cd /home/io/gcloud_home/gcp-app-test/exchange
nohup npm run exchange_local > /home/io/scraper-logs/exchange.log 2>&1 &
echo $$ > exchange.pid
cd -




