#!/bin/sh

echo "deploying app"
kubectl apply -f hellogo-dep-svc.yaml
sleep 5
echo "paste this url in browser"
sleep 10
aws elb describe-load-balancers --query "LoadBalancerDescriptions[].DNSName" --output text