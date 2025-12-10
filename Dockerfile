FROM alpine:3.23.0

RUN apk add openjdk21

VOLUME ["/config"]