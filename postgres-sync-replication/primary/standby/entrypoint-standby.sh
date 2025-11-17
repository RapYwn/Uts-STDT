set -e

if [ -z "$(ls -A $PGDATA)" ]; then
    echo "Menunggu primary..."
    until pg_isready -h $PG_PRIMARY_HOST -p 5432 -U $REPL_USER; do sleep 1; done

    echo "Melakukan pg_basebackup..."
    export PGPASSWORD=$REPL_PASSWORD
    pg_basebackup -h $PG_PRIMARY_HOST -p 5432 -U $REPL_USER -D $PGDATA \
                  -v -P -W -S standby_slot --wal-method=stream -R
    unset PGPASSWORD


    echo "primary_conninfo = 'host=$PG_PRIMARY_HOST port=5432 user=$REPL_USER password=$REPL_PASSWORD application_name=db_standby'" >> $PGDATA/postgresql.auto.conf
    echo "hot_standby = on" >> $PGDATA/postgresql.conf
fi

echo "Menjalankan standby server..."
exec gosu postgres postgres