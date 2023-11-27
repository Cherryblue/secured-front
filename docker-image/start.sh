#!/bin/bash

# Copyright (C) 2023 Kynn/Cherryblue
#   This file is part of Secured-front (https://github.com/Cherryblue/secured-front).
#   Secured-front is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#   Secured-front is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#   You should have received a copy of the GNU General Public License along with Secured-front. If not, see <https://www.gnu.org/licenses/>. 

echo "### Starting services.."
crond
rsyslogd
sleep 5s

echo "### Starting HaProxy.."
tail -f /var/log/messages&
/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg&

echo "### HaProxy Started"
sleep infinity
