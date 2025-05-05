#!/bin/sh
# wait-for.sh

host="$1"
shift
until nc -z "$host" 5432; do
  echo "Waiting for Postgres at $host:5432..."
  sleep 2
done

exec "$@"
