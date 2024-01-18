FROM oraclelinux:9

RUN yum install -y patch git gcc pcre-devel zlib-devel openssl-devel vim

RUN yum install -y wget

RUN wget http://nginx.org/download/nginx-1.24.0.tar.gz \
    && tar -xzvf nginx-1.24.0.tar.gz 

RUN git clone https://github.com/chobits/ngx_http_proxy_connect_module.git

RUN cd nginx-1.24.0 \
    && patch -p1 < ../ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch \
    && ./configure \
    --user=www \
    --group=www \
    --prefix=/usr/local/nginx \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-threads \
    --add-module=../ngx_http_proxy_connect_module \
    && make \
    && make install

RUN useradd -s /sbin/nologin www
# COPY nginx.service /etc/systemd/system/nginx.service
# CMD ["/usr/local/nginx/sbin/nginx"]
# CMD ["/usr/local/nginx/sbin/nginx"]

COPY forward.conf /usr/local/nginx/conf/nginx.conf
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]