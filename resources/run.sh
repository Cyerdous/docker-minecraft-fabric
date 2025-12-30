#!/bin/bash

cd /config

if [ "${dedicated_ram:-0}" -eq 0 ]; then
	echo "ERROR: No amount of RAM added"
	exit 1
fi

if [ "${eula:-0}" != "true" ]; then
	echo "ERROR: You must agree to the eula"
	exit 1
fi

# ensure all files exist
touch server.properties
mkdir ./worlds

if [ "${level_name:-null}" != null ]; then
	echo "Setting server.properties level-name=/config/worlds/${level_name}"
	sed -i "s,^level-name=.*$,level-name=/worlds/${level_name},g" ./server.properties
else
	echo "Setting server.properties level-name=/config/worlds/world"
	sed -i "s,^level-name=.*$,level-name=/worlds/world,g" ./server.properties
fi
if [ "${level_seed:-null}" != null ]; then
	echo "Setting server.properties level-seed=${level_seed}"
	sed -i "s/^level-seed=.*$/level-seed=${level_seed}/g" ./server.properties
fi

# use fabric installer to get most recent minecraft version
readarray -t lines < <(java -jar /fabric-installer-1.1.0.jar help)
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
	echo "Setting Minecraft version to $version_minecraft"
	MCVERSION=$version_minecraft
fi

# if server has fabric version conf
if [ "${version_fabric:-null}" != null ]; then
	## set loaderversion to env $version_fabric
	echo "Setting Fabric Loader version to $version_fabric"
	LOADERVERSION=$version_fabric
fi

# enable agreeing to the eula from docker run or compose
echo "eula=${eula}" > /eula.txt

# if jar does not exist
if [ ! -f "fabric-server-mc.${MCVERSION}-loader.${LOADERVERSION}-launcher.1.1.0.jar" ]; then
	echo "Downloading Minecraft fabric server jar"
	curl -OJ https://meta.fabricmc.net/v2/versions/loader/${MCVERSION}/${LOADERVERSION}/1.1.0/server/jar
	wait
fi

java -Xmx${dedicated_ram}G -jar fabric-server-mc.${MCVERSION}-loader.${LOADERVERSION}-launcher.1.1.0.jar nogui