#!/bin/bash
set -e

echo "Aguardando banco de dados..."
until PGPASSWORD=citrine psql -h "ocpp-db" -U "citrine" -d "citrine" -c '\dx' | grep -q 'postgis\|uuid-ossp'; do
  >&2 echo "Postgres ou extensões ainda não disponíveis - sleeping"
  sleep 2
done

echo "Extensões detectadas. Aguardando mais 5 segundos para garantir inicialização completa..."
sleep 5

# echo "Banco de dados está pronto. Registrando carregador cp001..."
# PGPASSWORD=citrine psql -h "ocpp-db" -U "citrine" -d "citrine" -f /usr/local/apps/citrineos/Server/scripts/init-db.sql

echo "Iniciando aplicação..."
cd /usr/local/apps/citrineos

# A sincronização do banco será feita automaticamente pelo CitrineOS Server
# quando SYNC_DB=true no ambiente
exec "$@" 