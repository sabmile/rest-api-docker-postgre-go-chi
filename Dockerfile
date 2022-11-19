FROM golang:1.14.6-alpine3.12 as builder
COPY go.mod go.sum $GOPATH/src/github.com/sabmile/rest-api-docker-postgre-go-chi/
WORKDIR $GOPATH/src/github.com/sabmile/rest-api-docker-postgre-go-chi
RUN go mod download
COPY . $GOPATH/src/github.com/sabmile/rest-api-docker-postgre-go-chi
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/rest-api-docker-postgre-go-chi github.com/sabmile/rest-api-docker-postgre-go-chi
FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder $GOPATH/src/github.com/sabmile/rest-api-docker-postgre-go-chi/build/rest-api-docker-postgre-go-chi $GOPATH/bin/rest-api-docker-postgre-go-chi
EXPOSE 8080 8080
ENTRYPOINT ["$GOPATH/bin/rest-api-docker-postgre-go-chi"]

