FROM overware/minecraft-vanilla:latest

LABEL maintainer="Anthony THOMAS (TimmY80),Jeremy HERGAULT (reneca)" \
      description="Image that runs a Minecraft Forge Server. This image is based over overware/minecraft-vanilla and provides the same basic features: backup, gracefull start/stop, commands, ..." \
      github="https://github.com/Timmy80/minecraft-forge"

ARG MINECRAFT_VERSION=latest
# you can get the latest or the recommanded version of forge for your version of minecraft
ARG FORGE_TARGET=recommended

# copy the ressources for this container
COPY resources/*   /usr/local/minecraft/

RUN rm /minecraft/minecraft_server*.jar \
&& cd /tmp \
&& /usr/local/minecraft/downloadMinecraftForge.py -v $MINECRAFT_VERSION -t $FORGE_TARGET \
&& java -jar forge*installer.jar --installServer \
&& cp /tmp/forge*universal.jar /minecraft/ \
&& cp /tmp/minecraft_server*.jar /minecraft/ \
&& cp -r /tmp/libraries /minecraft/ \
&& rm -rf /tmp/*  \
&& sed -i "s/minecraft_server\*\.jar/forge\*universal\.jar/g" /usr/local/minecraft/minecraft.sh 




