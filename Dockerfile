FROM alpine:3.23.0

RUN sed -i '2s/^# *//' /etc/apk/repositories

RUN apk add bash
RUN apk add openjdk21
RUN apk add curl

EXPOSE 25565

COPY ./resources /

RUN chmod +x /run.sh

VOLUME ["/config"]

ENTRYPOINT ["/run.sh"]