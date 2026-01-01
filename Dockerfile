FROM eclipse-temurin:25-jdk-alpine-3.23

RUN sed -i '2s/^# *//' /etc/apk/repositories

RUN apk add bash
RUN apk add curl
RUN apk add libudev-zero

EXPOSE 25565

COPY ./resources /

RUN chmod +x /run.sh

VOLUME ["/config"]

CMD ["/run.sh"]