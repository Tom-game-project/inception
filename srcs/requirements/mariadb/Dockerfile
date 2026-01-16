FROM alpine:3.22

# 必要なパッケージのインストール
RUN apk update && apk add --no-cache mariadb mariadb-client bash

# ディレクトリの作成と権限設定
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# 設定ファイルとスクリプトのコピー
COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

# 実行権限の付与
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mariadbd", "--user=mysql"]
