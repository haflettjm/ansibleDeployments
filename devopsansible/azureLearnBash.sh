#! /bin/bash

PASSWORD_VALUE = $2
APPID_VALUE = $3
ARM_CLIENT_ID = $4


while getopts ":s:t:cl:cls" opt; do
  case ${opt} in
    s) export ARM_SUBSCRIPTION_ID="$OPTARG";;
    t) export ARM_TENANT_ID="$OPTARG";;
    cl) export ARM_CLIENT_ID="$OPTARG";;
    cls) export ARM_CLIENT_SECRET="$OPTARG";;
    \? ) echo "Usage: cmd [-s] [-t] [-cl] [-cls]"
  esac
done

if [-s "$ARM_SUBSCRIPTION_ID"]; then
  echo "subscription id is required."
  exit 1
fi




az account set --subscription ${AZ_ACTIVE_SUBSCRIPTION}

az login

az ad create-for-rbac \
  --role="Contributor"\
  --scopes="/subscriptions/${AZ_ACTIVE_SUBSCRIPTION}"

mkdir tf && mkdir src && mkdir k8s && mkdir .workflow

touch tf/main.tf && touch main.js && touch deploy.yaml && touch dev-deploy.yaml

cd tf/ && terraform init

cd ../


