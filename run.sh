#!/bin/bash

git clone https://github.com/aankittcoolest/terraform.git
cd terraform/01-deploy-public-ec2
gsed -i "s/ap-southeast-1/ap-south-1/" main.tf
terraform init
export TF_VAR_key_name=ec2-vpn
export TF_VAR_azs='["ap-south-1a", "ap-south-1b", "ap-south-1c"]'
export TF_VAR_ami_id=ami-0d980397a6e8935cd
export TF_VAR_user_data='#!/bin/bash
yum install -y docker git
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose
systemctl enable docker.service
systemctl start docker.service
cd /tmp
git clone https://github.com/aankittcoolest/forward-proxy.git
cd forward-proxy
docker-compose up --build -d
'
terraform apply -target=module.vpc -auto-approve
terraform apply -target=module.public-subnets -target=module.private-subnets -auto-approve
terraform apply -auto-approve