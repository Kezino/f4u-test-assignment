#!/bin/bash
set -e

TARGET_UID=$(stat -c "%u" /etc/nginx/sites-enabled/f4u-test.conf)
TARGET_GID=$(stat -c "%g" /etc/nginx/sites-enabled/f4u-test.conf)

if [ $TARGET_UID != 0 ] || [ $TARGET_GID != 0 ]; then
    echo '* Working around permission errors by making sure that "symfony" has the same uid and gid as the host user'
fi

if [ $TARGET_UID != 0 ]; then
    echo ' -- Setting symfony uid to '$TARGET_UID
    usermod -o -u $TARGET_UID symfony || true
fi

if [ $TARGET_GID != 0 ]; then
    echo ' -- Setting symfony gid to '$TARGET_GID
    groupmod -o -g $TARGET_GID symfony || true
fi

exec "$@"
