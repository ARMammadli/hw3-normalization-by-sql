#!/bin/bash

xlsx2csv /data/Unnormalized1.xlsx /data/data.csv

sleep 10

PGPASSWORD=$POSTGRES_PASSWORD psql -h localhost -U $POSTGRES_USER -d $POSTGRES_DB -c "\COPY unnormalized FROM '/data/data.csv' WITH (FORMAT csv, HEADER true);"

echo "Data loaded successfully."