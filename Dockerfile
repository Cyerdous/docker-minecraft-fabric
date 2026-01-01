FROM archlinux:base

RUN pacman -Syu --noconfirm jdk-openjdk

EXPOSE 25565

COPY ./resources /

RUN chmod +x /run.sh

VOLUME ["/config"]

ENTRYPOINT ["/run.sh"]