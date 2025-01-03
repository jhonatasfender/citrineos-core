#!/bin/bash
set -e

echo "Verificando containers ativos..."
RUNNING_CONTAINERS=$(docker ps --format '{{.Names}}' | grep -E 'citrine|everest|server_|rabbitmq|directus' || true)

if [ -n "$RUNNING_CONTAINERS" ]; then
    echo "Containers ativos encontrados:"
    echo "$RUNNING_CONTAINERS"
    
    echo -e "\nParando containers do CitrineOS..."
    docker-compose -f docker-compose.yml down -v
    
    echo "Parando containers do EVerest..."
    cd everest && docker-compose down -v && cd ..
else
    echo "Nenhum container ativo encontrado"
fi

echo -e "\nListando imagens relacionadas..."
IMAGES=$(docker images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -E 'citrineos|everest|rabbitmq|directus|mqtt-server|manager|nodered' || true)

if [ -n "$IMAGES" ]; then
    echo "Imagens encontradas:"
    echo "$IMAGES"
    echo -e "\nRemovendo imagens..."
    echo "$IMAGES" | awk '{print $2}' | xargs docker rmi -f
else
    echo "Nenhuma imagem relacionada encontrada"
fi

echo -e "\nRemovendo redes Docker..."
NETWORKS=$(docker network ls --format '{{.Name}}' | grep -E 'server_|everest_' || true)
if [ -n "$NETWORKS" ]; then
    echo "Redes encontradas:"
    echo "$NETWORKS"
    echo "$NETWORKS" | xargs docker network rm || true
else
    echo "Nenhuma rede relacionada encontrada"
fi

echo -e "\nRemovendo volumes..."
docker volume rm -f server_pgdata 2>/dev/null || true

echo "Removendo diretórios de dados..."
rm -rf ./data/directus/uploads/* 2>/dev/null || true
rm -rf ./data/rabbitmq/* 2>/dev/null || true

echo "Limpeza concluída!" 