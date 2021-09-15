#!/bin/sh
export VPC=$(terraform output -json | jq '."vpc_id"."value"' | sed "s/\"//g" )

export DB_HOST=$(terraform output -json | jq '."db_endpoint"."value"' | sed "s/\"//g" | sed "s/:.*//" )

export PRIVATE_SUBNET_1=$(terraform output -json | jq '."private_subnet_id_1"."value"' | sed "s/\"//g" )
export PRIVATE_SUBNET_2=$(terraform output -json | jq '."private_subnet_id_2"."value"' | sed "s/\"//g" )

export PUBLIC_SUBNET_1=$(terraform output -json | jq '."public_subnet_id_1"."value"' | sed "s/\"//g" )
export PUBLIC_SUBNET_2=$(terraform output -json | jq '."public_subnet_id_2"."value"' | sed "s/\"//g" )

cat cluster-template.yaml | sed "s/__VPC__/$VPC/g" | sed "s/__PRIVATE_SUBNET_1__/$PRIVATE_SUBNET_1/g" | sed "s/__PRIVATE_SUBNET_2__/$PRIVATE_SUBNET_2/g" | sed "s/__PUBLIC_SUBNET_1__/$PUBLIC_SUBNET_1/g" | sed "s/__PUBLIC_SUBNET_2__/$PUBLIC_SUBNET_2/g"  > koho-cluster.yaml

eksctl create cluster -f koho-cluster.yaml


# kubectl create service externalname postgres-svc --external-name $DB_HOST

# kubectl create secret generic dbcon --from-literal=DB_HOST=$(terraform output -json | jq '."db_endpoint"."value"' | sed "s/\"//g" | sed "s/:.*//" ) --from-literal=DB_PORT=5432 --from-literal=DB_USER=postgres --from-literal=DB_PASS=postgres --from-literal=DB_NAME=postgres --from-literal=DB_DIALECT=postgres

# kubectl run -it --rm --image=postgres --restart=Never postgres -- psql postgres://postgres:postgres@${DB_HOST}:5432/postgres


# CREATE TABLE welcome (column1 TEXT);
# insert into welcome values ('------------------------------------------------------------');
# insert into welcome values ('Welcome to the devops takehome evaluation from Giomar Garcia');
# insert into welcome values ('------------------------------------------------------------');

# \d
# SELECT * FROM welcome;
# \q

# kubectl apply -f ../hellogo-dep-svc.yaml

# kubectl get svc
# aws elb describe-load-balancers --query "LoadBalancerDescriptions[].DNSName" --output text
