#!/bin/bash

#Push docker image to ECR

. ./aws_env.sh

export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?"AWS access key id not set."}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?"AWS secret key not set."}
export AWS_ECR_REPO=${AWS_ECR_REPO:?"ECR repo not set."}
export AWS_REGION=${AWS_REGION:?"ECR Host not set."}

docker tag flask-web-server:latest ${AWS_ECR_REPO}:latest
$(aws ecr get-login --no-include-email --region $AWS_REGION)
docker push ${AWS_ECR_REPO}:latest

