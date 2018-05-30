#!/bin/bash -x

#https://kubernetes.io/docs/concepts/containers/images/
#https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html
#https://stackoverflow.com/questions/49654457/how-to-auto-deploy-docker-containers-from-amazon-ecr-to-kubernetes-using-jenkins
#https://medium.com/@xynova/keeping-aws-registry-pull-credentials-fresh-in-kubernetes-2d123f581ca6

. ./aws_env.sh

export AWS_ECR_REPO=${AWS_ECR_SERVER:?"ECR server not set."}
export AWS_REGION=${AWS_REGION:?"AWS region not set."}
export AWS_ACCOUNT=${AWS_ACCOUNT:?"ECR account not set."}
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?"AWS access key id not set."}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?"AWS secret key not set."}

#
# RUN me where kubectl is available,& make sure to replace account,region etc
#
SECRET_NAME=ecr-registry-key
EMAIL=any@email.com

#following command requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY defined
PASSWORD=`aws ecr get-login --region ${AWS_REGION} --registry-ids ${AWS_ACCOUNT} | cut -d' ' -f6`

#
# Create or replace registry secret
#

sudo kubectl delete secret --ignore-not-found $SECRET_NAME
sudo kubectl create secret docker-registry $SECRET_NAME \
 --docker-server=https://${AWS_ECR_SERVER} \
 --docker-username=AWS \
 --docker-password="${PASSWORD}" \
 --docker-email="${EMAIL}"
