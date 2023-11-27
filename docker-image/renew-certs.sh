#!/bin/bash

# Copyright (C) 2023 Kynn/Cherryblue
#   This file is part of Secured-front (https://github.com/Cherryblue/secured-front).
#   Secured-front is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#   Secured-front is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#   You should have received a copy of the GNU General Public License along with Secured-front. If not, see <https://www.gnu.org/licenses/>. 

DIR_ROOT="/certs"

# NGINX is only launched during dehydrated attempt to renew the certs
nginx&
dehydrated -c
killall nginx

# Adapting let's encrypt certs for HAPROXY
for dir in $DIR_ROOT/*/; do
        if [ -d "${dir}" ]; then
                cat ${dir}fullchain.pem ${dir}privkey.pem > ${dir}ck.pem
        fi
done

# Restarting HAPROXY to take into account new certs
/scripts/restart.sh
