FROM alpine:3.23.0

RUN sed -i '2s/^# *//' /etc/apk/repositories

RUN apk add bash
RUN apk add openjdk21
RUN apk add curl

EXPOSE 25565

COPY ./resources /

RUN chmod +x /run.sh

RUN <<LINKS
	ln -s /config/.fabric /.fabric
	ln -s /config/libraries /libraries
	ln -s /config/logs /logs
	ln -s /config/mods /mods
	ln -s /config/versions /versions
	ln -s /config/banned-ips.json /banned-ips.json
	ln -s /config/banned-players.json /banned-players.json
	ln -s /config/ops.json /ops.json
	ln -s /config/server.properties /server.properties
	ln -s /config/usercache.json /usercache.json
	ln -s /config/whitelist.json /whitelist.json
LINKS

VOLUME ["/config"]

ENTRYPOINT ["/run.sh"]