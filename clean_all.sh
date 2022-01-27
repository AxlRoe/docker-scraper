#!/bin/bash


echo "cleaning topics"
TOPICS=$(/usr/local/bin/kafka/./kafka-topics.sh --bootstrap-server localhost:9092 --list | grep TEST); for t in $TOPICS; do /usr/local/bin/kafka/./kafka-topics.sh --bootstrap-server localhost:9092 --topic $t --delete; done

echo "cleaning redis"
rdcli flushall

echo "cleaning db"
export PGPASSWORD='postgres'
psql -h localhost -U postgres -f clean.sql

echo "cleaning exchange"
cd /home/io/gcloud_home/gcp-app-test/exchange
./dump.sh
cd -
