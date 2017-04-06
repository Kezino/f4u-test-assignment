#!/bin/bash
set -e

runFixture() {
    case "$1" in
        *.sql)    echo "$0: loading $1 into $2"; "${mysql[@]}" "$2" < "$1"; echo ;;
        *.sql.gz) echo "$0: loading $1 into $2"; gunzip -c "$1" | "${mysql[@]}" "$2"; echo ;;
        *.sql.zip) echo "$0: loading $1 into $2"; unzip -p "$1" | "${mysql[@]}" "$2"; echo ;;
        *)        echo "$0: ignoring $1" ;;
    esac
}

echo '* Importing fixtures'
for db in /docker-entrypoint-fixtures.d/*; do
    if [ -d $db ]; then
        for f in $db/*; do
            runFixture $f $(basename $db)
            echo
        done
    else
        runFixture $db $(basename "$db" | cut -d. -f1)
    fi
done