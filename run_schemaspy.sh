#!/usr/bin/env bash
set -u
set -e
set -o noclobber

# 先ほどJARファイルを配置したディレクトリ
JDBC_DRIVER_DIR=/root
JDBC_DRIVER_PATH=${JDBC_DRIVER_PATH:-$(echo ${JDBC_DRIVER_DIR}/*.jar| sed "s/ /:/g")}

# ここでは "PostgreSQL" に特化させました
DATABASE_TYPE=${DATABASE_TYPE:-pgsql}

# 接続対象DBホスト
DB_HOST=${DB_HOST:-localhost}
# 接続対象DB名
DB_NAME=${DB_NAME:-postgres}
# 接続対象DBユーザ
DB_USER=${DB_USER:-postgres}
# 接続対象DBパスワード
DB_PASS=${DB_PASS:-}


[ ! -d "/output/${DB_NAME}" ] && mkdir -p "/output/${DB_NAME}"

# -hq           :ハイクオリティモード。出力結果がきれいになる！
# -noimplied    :「外部キーがない既存テーブル間の関連を推測し、ER図に反映してくれる」機能をOFFにする
java \
    -jar      "/root/schemaspy-6.0.0-rc2.jar" \
    -hq \
    -noimplied \
    -o        "/output/${DB_NAME}" \
    -charset  utf-8 \
    -dp       "${JDBC_DRIVER_PATH}" \
    -t        "${DATABASE_TYPE}" \
    -host     "${DB_HOST}" \
    -s        "public" \
    -db       "${DB_NAME}" \
    -u        "${DB_USER}" \
    -p        "${DB_PASS}" \
    ;
