#!/bin/sh


eksctl delete cluster -f koho-cluster.yaml
rm koho-cluster.yaml
sleep 15
terraform destroy --auto-approve