FROM golang:1.17 as builder
WORKDIR /go/src/github.com/RobustPerception/azure_metrics_exporter
COPY . .
RUN CGO_ENABLED=0 go build

FROM alpine:latest AS app

COPY --from=builder /go/src/github.com/RobustPerception/azure_metrics_exporter/azure_metrics_exporter /bin/azure_metrics_exporter
COPY --from=builder /go/src/github.com/RobustPerception/azure_metrics_exporter/azure-all-postgres.yml /azure.yml

EXPOSE 9276
ENTRYPOINT ["/bin/azure_metrics_exporter"]
