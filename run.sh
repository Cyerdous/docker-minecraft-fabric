#!/bin/bash

# use fabric installer to get most recent minecraft version
readarray -t lines < <(java -jar ./resources/fabric-installer-1.1.0.jar help)
for line in "${lines[@]}"; do
	if [[ $line =~ "Latest Version:" ]]; then
		## set mcversion to most recent stable minecraft version
		MCVERSION=$(echo $line| cut -d' ' -f 3)
	fi
	if [[ $line =~ "Latest Loader:" ]]; then
		## set loaderversion to most recent Fabric Loader version
		LOADERVERSION=$(echo $line| cut -d' ' -f 3)
	fi
done

# if server has minecraft version conf
if [ "${version_minecraft:-null}" != null ]; then
	## set mcversion to env $version_minecraft
	MCVERSION=$version_minecraft
fi

# if server has fabric version conf
if [ "${version_fabric:-null}" != null ]; then
	## set loaderversion to env $version_fabric
	LOADERVERSION=$version_fabric
fi

# if "fabric-server-mc.{mcversion=$version_minecraft}-loader.{loaderversion=$version_fabric}-launcher.{launcherversion=1.1.0}.jar does not exist"
if [ ! -f "fabric-server-mc.${MCVERSION}-loader.${LOADERVERSION}-launcher.1.1.0.jar" ]
	curl -OJ https://meta.fabricmc.net/v2/versions/loader/${MCVERSION}/${LOADERVERSION}/1.1.0/server/jar
fi

java -Xmx${dedicated_ram}G -jar fabric-server-mc.${MCVERSION}-loader.${LOADERVERSION}-launcher.1.1.0.jar nogui