#!/bin/bash
databases=("bluecore,bluecore_admin", "keycloak,keycloak")

for database in "${databases[@]}"; do
  IFS=',' read -r -a parts <<< "$database"
  echo "Creating database ${parts[0]}"
  psql -v ON_ERROR_STOP=1 --username airflow <<-EOSQL
    SELECT 'CREATE DATABASE ${parts[0]}' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${parts[0]}')\gexec
    GRANT ALL PRIVILEGES ON DATABASE '${parts[0]}' TO airflow;
EOSQL
done
