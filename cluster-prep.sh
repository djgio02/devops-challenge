#!/bin/sh

echo "creating externalName"
kubectl create service externalname postgres-svc --external-name $DB_HOST

echo "creating secrets"
kubectl create secret generic dbcon --from-literal=DB_HOST=$(terraform output -json | jq '."db_endpoint"."value"' | sed "s/\"//g" | sed "s/:.*//" ) --from-literal=DB_PORT=5432 --from-literal=DB_USER=postgres --from-literal=DB_PASS=postgres --from-literal=DB_NAME=postgres --from-literal=DB_DIALECT=postgres

echo "use this container to load data into database"
kubectl run -it --rm --image=postgres --restart=Never postgres -- psql postgres://postgres:postgres@${DB_HOST}:5432/postgres


# CREATE TABLE welcome (column1 TEXT);
# insert into welcome values ('------------------------------------------------------------');
# insert into welcome values ('Welcome to the devops takehome evaluation from Giomar Garcia');
# insert into welcome values ('------------------------------------------------------------');

# \d
# SELECT * FROM welcome;
# \q
