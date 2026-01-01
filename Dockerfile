FROM alpine:3.23.0

RUN sed -i '2s/^# *//' /etc/apk/repositories

RUN apk add bash
RUN apk add openjdk25
RUN apk add ca-certificates
RUN apk add curl
RUN apk add libudev-zero

EXPOSE 25565

COPY ./resources /

RUN chmod +x /run.sh

VOLUME ["/config"]

ENTRYPOINT ["/run.sh"]