# Copyright (C) 2023 Kynn/Cherryblue
#   This file is part of Secured-front (https://github.com/Cherryblue/secured-front).
#   Secured-front is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#   Secured-front is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#   You should have received a copy of the GNU General Public License along with Secured-front. If not, see <https://www.gnu.org/licenses/>. 

# Using Alpine as base for image
FROM alpine:3.18.4 as main
RUN apk update

# Adding Cert Generator Tool
RUN wget https://github.com/lukas2511/dehydrated/archive/master.tar.gz && \
	mkdir /usr/local/dehydrated && \
	tar -zxf master.tar.gz --directory /usr/local && \
	mv /usr/local/dehydrated-master/* /usr/local/dehydrated/ && \
	rm master.tar.gz && \
	rm -R /usr/local/dehydrated-master && \
	ln -s /usr/local/dehydrated/dehydrated /bin/dehydrated

# Adding HAProxy to the system
RUN apk add haproxy

# Adding NGINX to the system
RUN apk add nginx

# Setting up dependencies
RUN apk add bash curl openssl sed nano

# Setting up Certificate adaptation & start script
COPY renew-certs.sh restart.sh start.sh /scripts/
RUN chmod +x /scripts/*.sh && \
    mkdir /var/www/dehydrated

# Setting up CRON 
RUN (crontab -l ; echo "0 5 * * 1 /scripts/renew-certs.sh") | crontab -

# Adding syslog
RUN apk add rsyslog && \
	sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

# Ports are not exposed here. 
# As this is a reverse-proxy and ports depend on the given services, you are encouraged to use this image with network_mode: "host"

# Removing apk cache
RUN rm -rf /var/cache/apk/*

# Launching process
ENTRYPOINT  [ "/bin/sh", "-c", "/scripts/start.sh" ]
