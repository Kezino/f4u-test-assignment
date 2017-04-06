#!/bin/bash
set -e

# Set symfony user same UID and GID as host user
TARGET_UID=$(stat -c "%u" /var/www/f4u-test)
TARGET_GID=$(stat -c "%g" /var/www/f4u-test)

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

# Composer
if [ -n "$GITHUB_API_TOKEN" ]; then
    gosu symfony composer config -g github-oauth.github.com $GITHUB_API_TOKEN
fi

if [ -n "$GIT_NAME" ]; then
    git config --global user.name "$GIT_NAME"
fi

if [ -n "$GIT_EMAIL" ]; then
    git config --global user.email "$GIT_EMAIL"
fi

crontab -u symfony /var/www/f4u-test/docker/app/conf/cron.conf

exec "$@"
