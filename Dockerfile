FROM golang:1.19.2-alpine3.16 as builder

WORKDIR /usr/src/app
COPY go.mod ./
RUN go mod download && go mod verify
COPY . .
RUN go build -v -o /usr/local/bin/app ./...


FROM alpine:3.16
WORKDIR /usr/local/bin/
COPY --from=builder /usr/local/bin/app .
ENTRYPOINT ["./app"]