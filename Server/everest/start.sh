#!/bin/sh

# Inicia o servidor HTTP para logs
http-server /tmp/everest_ocpp_logs -p 8888 &

# Ajusta a configuração para usar o nome correto do container do CitrineOS
sed -i 's/host.docker.internal/server-citrine-1/g' /ext/source/config/config-sil-ocpp201-pnc.yaml

# Dá permissão de execução ao script
chmod +x /ext/source/build/run-scripts/run-sil-ocpp201-pnc.sh

# Inicia o EVerest
/ext/source/build/run-scripts/run-sil-ocpp201-pnc.sh