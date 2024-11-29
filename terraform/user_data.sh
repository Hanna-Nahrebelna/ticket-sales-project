#!/bin/bash 

yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user


curl -SL https://github.com/docker/compose/releases/download/v2.29.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 339712948510.dkr.ecr.eu-north-1.amazonaws.com

docker pull 339712948510.dkr.ecr.eu-north-1.amazonaws.com/tickera/frontend:latest
docker pull 339712948510.dkr.ecr.eu-north-1.amazonaws.com/tickera/rds:latest
docker pull 339712948510.dkr.ecr.eu-north-1.amazonaws.com/tickera/redis:latest