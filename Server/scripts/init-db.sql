-- Criar extensão PostGIS (necessária para funcionalidades geoespaciais)
CREATE EXTENSION IF NOT EXISTS postgis;

-- Criar extensão para UUID (necessária para IDs únicos)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Configurações de performance do PostgreSQL
ALTER SYSTEM SET max_connections = '200';
ALTER SYSTEM SET shared_buffers = '512MB'; 

-- Criar tabela ChargingStations se não existir
CREATE TABLE IF NOT EXISTS "ChargingStations" (
    "id" VARCHAR(255) PRIMARY KEY,
    "isOnline" BOOLEAN DEFAULT false,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Inserir estação de carregamento padrão
INSERT INTO "ChargingStations" ("id", "isOnline", "createdAt", "updatedAt")
    VALUES ('cp001', false, NOW(), NOW())
    ON CONFLICT ("id") DO NOTHING;

-- Criar sequência para o carregador
INSERT INTO "ChargingStationSequences" ("stationId", "type", "value", "createdAt", "updatedAt")
VALUES ('cp001', 'MessageId', 0, NOW(), NOW())
ON CONFLICT ("stationId", "type") DO NOTHING;

-- Criar informações de segurança
INSERT INTO "ChargingStationSecurityInfo" ("stationId", "publicKeyFileId", "createdAt", "updatedAt")
VALUES ('cp001', 'default', NOW(), NOW())
ON CONFLICT ("stationId") DO NOTHING;

-- Criar perfil de rede
INSERT INTO "ServerNetworkProfiles" ("id", "ocppVersion", "securityProfile", "ocppTransport", "createdAt", "updatedAt")
VALUES ('default', 'OCPP20', 0, 'JSON', NOW(), NOW())
ON CONFLICT ("id") DO NOTHING;

INSERT INTO "SetNetworkProfiles" ("id", "configurationSlot", "connectionData", "createdAt", "updatedAt")
VALUES (1, 0, '{"ocppVersion":"OCPP20","ocppTransport":"JSON","securityProfile":0,"ocppCsmsUrl":"ws://server-citrine-1:8081/cp001"}', NOW(), NOW())
ON CONFLICT ("id") DO NOTHING;

INSERT INTO "ChargingStationNetworkProfiles" ("stationId", "configurationSlot", "setNetworkProfileId", "websocketServerConfigId", "createdAt", "updatedAt")
VALUES ('cp001', 0, 1, 'default', NOW(), NOW())
ON CONFLICT ("stationId", "configurationSlot") DO NOTHING;

-- Criar configuração de boot
INSERT INTO "Boots" ("id", "status", "heartbeatInterval", "bootRetryInterval", "getBaseReportOnPending", "bootWithRejectedVariables", "createdAt", "updatedAt")
VALUES ('cp001', 'Accepted', 60, 30, false, false, NOW(), NOW())
ON CONFLICT ("id") DO NOTHING;

-- Criar modelo do dispositivo
INSERT INTO "Components" ("name", "instance", "evseId", "stationId", "createdAt", "updatedAt")
VALUES 
('ChargingStation', NULL, NULL, 'cp001', NOW(), NOW()),
('DeviceDataCtrlr', NULL, NULL, 'cp001', NOW(), NOW())
ON CONFLICT ("name", "stationId") DO NOTHING;

-- Criar variáveis do modelo
INSERT INTO "Variables" ("name", "instance", "componentId", "stationId", "createdAt", "updatedAt")
SELECT 'Model', NULL, c.id, 'cp001', NOW(), NOW()
FROM "Components" c 
WHERE c.name = 'ChargingStation' AND c.stationId = 'cp001'
ON CONFLICT ("name", "componentId", "stationId") DO NOTHING;

INSERT INTO "Variables" ("name", "instance", "componentId", "stationId", "createdAt", "updatedAt")
SELECT 'VendorName', NULL, c.id, 'cp001', NOW(), NOW()
FROM "Components" c 
WHERE c.name = 'ChargingStation' AND c.stationId = 'cp001'
ON CONFLICT ("name", "componentId", "stationId") DO NOTHING;

INSERT INTO "Variables" ("name", "instance", "componentId", "stationId", "createdAt", "updatedAt")
SELECT 'ItemsPerMessage', 'SetVariables', c.id, 'cp001', NOW(), NOW()
FROM "Components" c 
WHERE c.name = 'DeviceDataCtrlr' AND c.stationId = 'cp001'
ON CONFLICT ("name", "componentId", "stationId") DO NOTHING;

-- Criar atributos das variáveis
INSERT INTO "VariableAttributes" ("type", "value", "mutability", "persistent", "constant", "variableId", "stationId", "createdAt", "updatedAt")
SELECT 'Actual', 'EVerest', 'ReadOnly', true, true, v.id, 'cp001', NOW(), NOW()
FROM "Variables" v 
JOIN "Components" c ON v.componentId = c.id 
WHERE v.name = 'Model' AND c.name = 'ChargingStation' AND c.stationId = 'cp001'
ON CONFLICT ("type", "variableId", "stationId") DO NOTHING;

INSERT INTO "VariableAttributes" ("type", "value", "mutability", "persistent", "constant", "variableId", "stationId", "createdAt", "updatedAt")
SELECT 'Actual', 'EVerest', 'ReadOnly', true, true, v.id, 'cp001', NOW(), NOW()
FROM "Variables" v 
JOIN "Components" c ON v.componentId = c.id 
WHERE v.name = 'VendorName' AND c.name = 'ChargingStation' AND c.stationId = 'cp001'
ON CONFLICT ("type", "variableId", "stationId") DO NOTHING; 