
###  Steps to deploy on AWS

```sh
sh run.sh
```

### Steps to test forward proxy
```sh
export AWS_EC2_PUBLIC_IP=<AWS_EC2_PUBLIC_IP>
curl https://www.hotstar.com -svo /dev/null -x $AWS_EC2_PUBLIC_IP:443
```

### Steps to destroy resources on AWS

```sh
cd terraform/01-deploy-public-ec2
terraform destroy -auto-approve
```