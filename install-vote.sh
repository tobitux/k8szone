#!/bin/bash

set -eup

cd ./..

if [ ! -d ./azure-voting-app-redis ];
then
    git clone https://github.com/Azure-Samples/azure-voting-app-redis.git
fi

cd azure-voting-app-redis
az acr build --image azure-vote-front:v1   --registry crk8szone   --file Dockerfile .