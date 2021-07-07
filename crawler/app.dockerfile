FROM golang:1.16.5-alpine3.14 AS builder

RUN mkdir /app  
WORKDIR /app

COPY crawler/go.mod crawler/go.sum ./
COPY crawler/vendor vendor

RUN go mod download

COPY . /app
RUN pwd
RUN ls -all

RUN apk --no-cache update  \
    && apk add --no-cache git tzdata \
    && CGO_ENABLED=0 GOOS=linux go build crawler/main.go

FROM scratch
WORKDIR /

COPY --from=builder /app/main .
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

ENV TZ=America/Sao_Paulo

#EXPOSE 9090

ENTRYPOINT ["/main"]