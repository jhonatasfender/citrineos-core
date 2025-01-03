FROM node:18 as build

WORKDIR /usr/local/apps/citrineos

COPY package*.json ./
COPY tsconfig*.json ./

COPY Server/package*.json Server/
COPY 00_Base/package*.json 00_Base/
COPY 01_Data/package*.json 01_Data/
COPY 02_Util/package*.json 02_Util/
COPY 03_Modules/Certificates/package*.json 03_Modules/Certificates/
COPY 03_Modules/Configuration/package*.json 03_Modules/Configuration/
COPY 03_Modules/EVDriver/package*.json 03_Modules/EVDriver/
COPY 03_Modules/Monitoring/package*.json 03_Modules/Monitoring/
COPY 03_Modules/OcppRouter/package*.json 03_Modules/OcppRouter/
COPY 03_Modules/Reporting/package*.json 03_Modules/Reporting/
COPY 03_Modules/SmartCharging/package*.json 03_Modules/SmartCharging/
COPY 03_Modules/Transactions/package*.json 03_Modules/Transactions/

RUN npm install

COPY . .

RUN npm run build
RUN ls -la 03_Modules/Monitoring/dist/
RUN ls -la node_modules/@citrineos/monitoring/dist/
RUN npm rebuild bcrypt --build-from-source && npm rebuild deasync --build-from-source
RUN ls -la dist/
RUN ls -la Server/dist/
RUN test -f Server/dist/index.js || exit 1

FROM node:18-slim

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/apps/citrineos

COPY --from=build /usr/local/apps/citrineos/node_modules ./node_modules
COPY --from=build /usr/local/apps/citrineos/Server/node_modules ./Server/node_modules
COPY --from=build /usr/local/apps/citrineos/00_Base/node_modules ./00_Base/node_modules
COPY --from=build /usr/local/apps/citrineos/01_Data/node_modules ./01_Data/node_modules
COPY --from=build /usr/local/apps/citrineos/02_Util/node_modules ./02_Util/node_modules
COPY --from=build /usr/local/apps/citrineos/03_Modules/*/node_modules ./03_Modules/*/node_modules

COPY --from=build /usr/local/apps/citrineos/dist ./dist
COPY --from=build /usr/local/apps/citrineos/Server/dist ./Server/dist
COPY --from=build /usr/local/apps/citrineos/00_Base/dist ./00_Base/dist
COPY --from=build /usr/local/apps/citrineos/01_Data/dist ./01_Data/dist
COPY --from=build /usr/local/apps/citrineos/02_Util/dist ./02_Util/dist
COPY --from=build /usr/local/apps/citrineos/03_Modules/*/dist ./03_Modules/*/dist

COPY --from=build /usr/local/apps/citrineos/03_Modules/*/package.json ./03_Modules/*/

RUN mkdir -p /tmp/scripts

RUN echo '#!/bin/bash\n\
echo "Listando conteúdo de /tmp/scripts:"\n\
ls -la /tmp/scripts/\n\
chmod +x /tmp/scripts/wait-for-db.sh\n\
/tmp/scripts/wait-for-db.sh && npm run start-docker-cloud' > /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

EXPOSE ${PORT}

CMD ["/usr/local/bin/entrypoint.sh"]
