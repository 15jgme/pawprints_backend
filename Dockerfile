ARG FROM_IMAGE=golang:1.19.4-alpine3.17
FROM $FROM_IMAGE
USER root

RUN mkdir -p github.com/15jgme/pawprints_backend/migrations

WORKDIR /go/src/github.com/15jgme/pawprints_backend/migrations
COPY migrations/pb_schema.json .
COPY migrations/1672761489_collections_snapshop.go .

WORKDIR /go/src/github.com/15jgme/pawprints_backend
COPY main.go .
COPY go.mod .
COPY startup.sh .

RUN go get github.com/pocketbase/pocketbase@v0.10.4
RUN apk add musl-dev
RUN apk add gcc
RUN go build -v main.go
#RUN ./main migrate collections

ENV PORT="127.0.0.1:8090"
EXPOSE 8090/udp
EXPOSE 8090/tcp
ENTRYPOINT ["/go/src/github.com/15jgme/pawprints_backend/startup.sh"]