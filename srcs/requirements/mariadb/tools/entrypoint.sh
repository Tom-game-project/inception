#!/bin/bash
set -e

# データディレクトリが空の場合のみ初期化を実行
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    
    # データベースディレクトリの初期化
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # 一時的にサーバーを起動して設定を行う
    mariadbd --user=mysql --bootstrap << EOF
        FLUSH PRIVILEGES;
        
        -- rootパスワードの設定 (ローカルホストのみ許可)
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
        
        -- WordPress用データベースとユーザーの作成
        CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
        
        FLUSH PRIVILEGES;
EOF
    echo "Database initialized."
fi

# CMDで渡されたコマンド(mariadbd)を実行
exec "$@"
