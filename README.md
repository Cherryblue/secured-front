# Secured-front
This is an attempt to isolate the reverse-proxy and the associated certificate software provider from the other services, inside one and only one container, as they do not benefit in any way from being separated. Thus reducing the time needed to setup a complex environment @Home (or anywhere else).

## Main softwares included
This attempt is currently based on two main softwares :
- HAProxy for the reverse proxy
- Dehydrated for the certificate software provider (which is a let's encrypt client)

## Complementary softwares
In order to work, this image does use other softwares listed here :
- NGINX, which is used as a webserver for let's encrypt challenge (in the process of generating the certificates). NGINX is only run when the certificates are renewed.
- CRON, which is used to renew the certificates on a fixed frequency, using a script.
- RSYSLOG, which is used to interpret HAProxy Logs on the associated socket
- Various unix/linux commands, which are used to setup the image (SED) or to read the logs on the container (TAIL).

## Scripts
The image comes with a few scripts explained below :
- /scripts/start.sh : used to start the container
- /scripts/restart.sh : can be used manually to restart haproxy. Is used automatically after renewing certificates, in order for HaProxy to load the new ones.
- /scripts/renew-certs.sh : starts and halts nginx, and calls for let's encrypt server in-between. Generates the cert files, and put them in the format expected by HAProxy.

## Special thanks
- To every software's authors, for all their hard work
- To Alpine Linux Team for making all this possible in a stupidly small form factor.

## First-run (steps needed to complete the setup)
For every software to be initialized :
> sudo docker compose up -d
> sudo docker exec -it secured-front sh
> /bin/dehydrated --register --accept-terms"

Once you've put the wanted domains in dehydrated-domains.txt, configured your network and port redirection for 80 & 443 :
> /scripts/renew-certs.sh

Once you've got the working certificates, and enriched haproxy.cfg with the wanted services and redirections :
> /scripts/restart.sh

.. Or simply restart the associated docker container.