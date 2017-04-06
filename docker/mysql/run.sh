#!/bin/bash
set -e

# Script to workaround docker-machine/boot2docker OSX host volume issues: https://github.com/docker-library/mysql/issues/99

TARGET_UID=$(stat -c "%u" /var/lib/mysql)
TARGET_GID=$(stat -c "%g" /var/lib/mysql)

if [ $TARGET_UID != 0 ] || [ $TARGET_GID != 0 ]; then
    echo '* Working around permission errors locally by making sure that "mysql" uses the same uid and gid as the host volume'
fi

if [ $TARGET_UID != 0 ]; then
    echo '-- Setting mysql user to use uid '$TARGET_UID
    usermod -o -u $TARGET_UID mysql || true
fi

if [ $TARGET_GID != 0 ]; then
    echo '-- Setting mysql group to use gid '$TARGET_GID
    groupmod -o -g $TARGET_GID mysql || true
fi

echo
echo '* Starting MySQL'
chown -R mysql:root /var/run/mysqld/
/entrypoint.sh mysqld --user=mysql --console
