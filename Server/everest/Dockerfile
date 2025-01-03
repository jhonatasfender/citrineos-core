ARG EVEREST_IMAGE_TAG=2024.9.0

FROM --platform=linux/x86_64 ghcr.io/everest/everest-demo/manager:${EVEREST_IMAGE_TAG}

ARG EVEREST_TARGET_URL=ws://server-citrine-1:8081/cp001
ENV EVEREST_TARGET_URL $EVEREST_TARGET_URL

WORKDIR /workspace

RUN ["/entrypoint.sh"]
RUN apk update && apk add sqlite

RUN sqlite3 /ext/source/build/dist/share/everest/modules/OCPP201/device_model_storage.db \
    "UPDATE VARIABLE_ATTRIBUTE \
    SET value = '[{\"configurationSlot\": 1, \"connectionData\": {\"messageTimeout\": 30, \"ocppCsmsUrl\": \"$EVEREST_TARGET_URL\", \"ocppInterface\": \"Wired0\", \"ocppTransport\": \"JSON\", \"ocppVersion\": \"OCPP20\", \"securityProfile\": 1}}]' \
    WHERE \
    variable_Id IN ( \
    SELECT id FROM VARIABLE \
    WHERE name = 'NetworkConnectionProfiles' \
    );"

RUN rm -f /ext/source/build/dist/etc/everest/certs/ca/v2g/*.*

RUN npm i -g http-server
EXPOSE 8888

COPY ./start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh
CMD ["sh", "-c", "/tmp/start.sh"]