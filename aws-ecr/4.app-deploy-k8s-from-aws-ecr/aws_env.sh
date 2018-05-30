#!/bin/bash

export AWS_ACCESS_KEY_ID=<>
export AWS_SECRET_ACCESS_KEY=<>
export AWS_REGION=us-west-2
export AWS_ACCOUNT=123456789012
export AWS_ECR_SERVER=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
export AWS_ECR_REPO=$AWS_ECR_SERVER/flask-web-server
