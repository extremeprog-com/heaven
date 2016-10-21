# heaven
Nginx container with LetsEncrypt SSL for simple Docker deployments.

## Deployment

```bash
$ docker run --name nginx --hostname=nginx \
                          -v /opt/containers:/opt/containers:ro \
                          -v /var/run:/var/run/host \
                          -v /usr/lib/systemd/system:/usr/lib/systemd/system/host \
                          -v /opt/containers/nginx/etc/letsencrypt:/etc/letsencrypt \
                          --cap-add=NET_ADMIN \
                          -e DOCKER_VERSION=`docker -v | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'` \
                          -p 80:80 -p 443:443 \
                          --restart=always \
                          extremeprog/heaven
                          
```

By default nginx routes all requests to all containers. Let's say a container name of your site is xxx.
Nginx will route all requests that come to xxx.any.com, xxx.many.any.com (any zone) to your container on port 80.

In order to add site to LetsEncrypt run

```bash
$ docker exec -it nginx /add_ssl_site.sh mycontainer.mydomain.com
```

where site_name is the name of your site.

If you need to route the requests to different port you can add configuration for your container to **/opt/containers/{name}/nginx/** folder.
It will be automatically retrieved by nginx.

In order to force LetsEncrypt to work in your container add to the config following lines:

```
location /.well-known {
  root /tmp;
}
```
