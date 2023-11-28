#
# build container
#
FROM --platform=linux/amd64 golang:1.19-alpine as builder
WORKDIR /

COPY rabbitmq_exporter_linux_amd64 /rabbitmq_exporter_linux_amd64

RUN chmod +x /rabbitmq_exporter_linux_amd64

EXPOSE     9419
ENTRYPOINT [ "/rabbitmq_exporter_linux_amd64" ]
