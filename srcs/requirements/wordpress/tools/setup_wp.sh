#!/bin/bash
set -e

# MariaDBが起動するまで待機
while ! mariadb -h"$SQL_HOST" -u"$SQL_USER" -p"$SQL_PASSWORD" $SQL_DATABASE &>/dev/null; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# WordPressが未インストールの場合にダウンロードと設定
if [ ! -f wp-config.php ]; then
    echo "Setting up WordPress..."
    
    # ダウンロード
    wp core download --allow-root

    # 設定ファイルの作成
    wp config create \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="${SQL_HOST}" \
        --allow-root

    # インストール
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${SITE_TITLE}" \
        --admin_user="${ADMIN_USER}" \
        --admin_password="${ADMIN_PASSWORD}" \
        --admin_email="${ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    # 追加ユーザーの作成
    wp user create \
        "${USER1_LOGIN}" \
        "${USER1_EMAIL}" \
        --role=author \
        --user_pass="${USER1_PASSWORD}" \
        --allow-root

    # コメントの手動承認を無効化（誰でも即座にコメントが表示されるようにする）
    wp option update comment_moderation 0 --allow-root
    wp option update comment_previously_approved 0 --allow-root
fi

exec "$@"
