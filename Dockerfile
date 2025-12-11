FROM alpine:3.23.0

RUN sed -i '2s/^# *//' /etc/apk/repositories

RUN apk add openjdk21

EXPOSE 25565

VOLUME ["/config"]

ENTRYPOINT ["./run.sh"]