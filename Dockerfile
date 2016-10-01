FROM linuxserver/baseimage
MAINTAINER Sparklyballs <sparklyballs@linuxserver.io> , LinuxServer.io - IronicBadger <docker@linuxserver.io>

ENV APTLIST="zip unzip"

# install packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

# fetch btsync packages
# stable
 curl -o /tmp/btsync_stable.tar.gz -L https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz && \
 mkdir -p /app/btsync-latest && \
 tar -xzvf /tmp/btsync_stable.tar.gz -C /app/btsync-latest && \
# legacy
 curl -o /tmp/btsync_legacy.tar.gz -L http://syncapp.bittorrent.com/1.4.111/btsync_x64-1.4.111.tar.gz && \
 mkdir -p /app/btsync-1.4 && \
 tar -xzvf /tmp/btsync_legacy.tar.gz -C /app/btsync-1.4 && \

# cleanup
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Adding Custom files
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Mappings and Ports
EXPOSE 8888 55555
VOLUME /config


