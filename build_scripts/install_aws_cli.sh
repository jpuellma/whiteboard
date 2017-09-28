#!/bin/bash -e

# Installs the AWS CLI utility rpms.
#

if [ ! -f /usr/local/aws/bin/aws ]; then
    yum -y install wget unzip
    wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
    unzip awscli-bundle.zip
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
fi
