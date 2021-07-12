FROM golang:1.16.5-alpine3.14 AS builder

RUN mkdir /app  
WORKDIR /app

RUN go mod download
RUN go mod vendor

COPY order/go.mod order/go.sum ./
COPY order/vendor vendor

COPY . /app

RUN apk --no-cache update  \
    && apk add --no-cache git tzdata \
    && CGO_ENABLED=0 GOOS=linux go build order/main.go

FROM scratch
WORKDIR /

ENV ELASTIC_APM_SERVICE_NAME="http://apm-server:8200"
ENV ELASTIC_APM_SERVER_URL="ORDER"

COPY --from=builder /app/main .
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

ENV TZ=America/Sao_Paulo

EXPOSE 8081

ENTRYPOINT ["/main"]