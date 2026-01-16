FROM alpine:3.22

# PHPと必要な拡張モジュール、クライアントツールのインストール
RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-phar \
    php83-mbstring \
    php83-tokenizer \
    php83-iconv \
    wget \
    bash \
    mariadb-client

# PHPコマンドへのシンボリックリンク
RUN ln -fs /usr/bin/php83 /usr/bin/php

# WP-CLIのインストール
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# PHP-FPMの設定（リッスンポートを9000に変更）
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php83/php-fpm.d/www.conf

# 作業ディレクトリ
WORKDIR /var/www/html

# セットアップスクリプト
COPY tools/setup_wp.sh /usr/local/bin/setup_wp.sh
RUN chmod +x /usr/local/bin/setup_wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup_wp.sh"]
CMD ["php-fpm83", "-F"]
