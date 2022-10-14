FROM alpine:3.16 as builder

RUN apk update && apk add go
WORKDIR /go/src/api
COPY . .
RUN go get -d -v && go build -ldflags "-s -w" -o bin/app

FROM scratch
WORKDIR /go/bin/
COPY --from=builder /go/src/api/bin/app .
ENTRYPOINT ["./app"]