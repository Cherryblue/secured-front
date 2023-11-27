#!/bin/bash

# Copyright (C) 2023 Kynn/Cherryblue
#   This file is part of Secured-front (https://github.com/Cherryblue/secured-front).
#   Secured-front is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#   Secured-front is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#   You should have received a copy of the GNU General Public License along with Secured-front. If not, see <https://www.gnu.org/licenses/>. 

# We make sure it wasn't running
echo "### Restarting HaProxy.."
killall haproxy
if [ -f "/var/run/haproxy.pid" ]; then
	rm /var/run/haproxy.pid
fi

# We launch it back
/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg&
echo "### HaProxy Started"
