
1. Install docker on ec2 instance.

```sh
yum install -y docker git
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose
systemctl enable docker.service
systemctl start docker.service

git clone https://github.com/aankittcoolest/forward-proxy.git
docker-compose up --build -d
```