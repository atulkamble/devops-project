#!/bin/sh

host="$1"
shift

echo "Waiting for $host:5432 to be reachable..."

until nc -z "$host" 5432; do
  echo "Still waiting for $host:5432..."
  sleep 2
done

echo "PostgreSQL is available — starting app"
exec "$@"
