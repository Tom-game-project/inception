FROM alpine:3.22

# NGINXとOpenSSLのインストール
RUN apk update && apk add --no-cache nginx openssl

# SSL証明書の生成
RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=Student/CN=login.42.fr"

# 設定ファイルのコピー
COPY conf/nginx.conf /etc/nginx/nginx.conf

# 必要なディレクトリの確保
RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
