
## Steps

1. Run nginx as forward proxy.

```sh
docker run --name my-custom-nginx-container -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx
```