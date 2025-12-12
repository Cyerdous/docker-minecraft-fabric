# cyerdous/minecraft-fabric
[Fabric](https://github.com/FabricMC/fabric) and [Fabric Loader](https://github.com/FabricMC/fabric-loader) create an easy to use, lightweight, modded server for Minecraft.
## Docker Compose
```
services:
  minecraft-fabric:
    container_name: 'minecraft-fabric'
    image: 'ghcr.io/cyerdous/minecraft-fabric:main'
    environment:
      - dedicated_ram=2 # Amount of RAM in GB
      - eula=true
      - level_seed= # Optional
      - level_name= # Optional
      - version_minecraft= # Optional 
      - version_fabric= # Optional
    ports:
      - 25565:25565
    # - 25575:25575 # Optional, allows for remote command execution
    volumes:
      - /path/to/minecraft/config:/config
    stdin_open: true
    tty: true
```
##   Variables

| Environment          | Function                                                                                                 |
| -------------------- | -------------------------------------------------------------------------------------------------------- |
| `*dedicated_ram`     | Amount of ram to allocate to the server via launch command                                               |
| `*eula`              | Agree to Minecraft's End User License Agreement to start the server                                      |
| `level_seed`         | Defines the default seed for world generation                                                            |
| `level_name`         | Selects the world for the server to launch, if blank defaults to 'world'                                 |
| `version_minecraft`  | Selects the version of Minecraft to launch, defaults to the most recent stable version                   |
| `version_fabric`     | Selects the version of the Fabric loader to use, defaults to the most recent version                     |
| **Port**             | **Function**                                                                                             |
| `*25565:25565`       | Connection used to allow players to join the server.                                                     |
| `25575:25575`        | Remote Console connection to allow server administrator remote command execution, disabled by default.   |
| **Volume**           | **Function**                                                                                             |
| /config              | Where Minecraft should store configuration and world files.                                              |
| **Parameter**        | **Function**                                                                                             |
| `stdin_open` & `tty` | Allows the server to have an interactive shell, accessible by docker attach or other management software |
\*required