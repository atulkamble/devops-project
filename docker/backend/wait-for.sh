#!/bin/sh

host="$1"
shift

echo "Waiting for PostgreSQL to be healthy on $host..."

# Loop until pg_isready returns success
until pg_isready -h "$host" -p 5432 -U postgres > /dev/null 2>&1; do
  echo "Still waiting for $host to become ready..."
  sleep 2
done

echo "$host is healthy! Starting backend..."
exec "$@"
