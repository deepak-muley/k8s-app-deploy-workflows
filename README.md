Steps:


pushd app-build

./build.sh

popd


pushd app-test

./run.sh

curl http://127.0.0.1:5000/

popd



pushd aws-ecr/3.app-publish-aws-ecr

. ./setup.sh

./push_app_ecr.sh

popd



#On k8s setup, copy folder 4.app-deploy-k8s-from-aws-ecr

pushd 4.app-deploy-k8s-from-aws-ecr

. ./setup.sh

./create_k8s_aws_docker_registry_secret.sh

kubectl create -f flask-web-server.yaml

./test.sh

popd

