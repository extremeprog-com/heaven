# Heaven
Nginx container with LetsEncrypt SSL for simple Docker deployments.

## Installation

```bash
$ docker run --name heaven --hostname=heaven -d \
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

By default Heaven routes all requests to all containers. Let's consider container name of your site to be **xxx**.
Heaven will route all requests that come to xxx.any.com, xxx.many.any.com (any zone) to your container on port 80.

Heaven reads additional nginx configurations for your site from `/opt/containers/xxx/nginx` folder. You should just add the file with any name with `.conf` extention. For example, it can be useful if you want heaven to route requests to other port.

After installation your site will be available over `http` or `https` automatically.

### For Rancher-based deployments
We have our own Rancher catalog. You can add it manually to your Rancher and install Heaven stack from there. Further reading https://github.com/extremeprog-com/rancher-catalog.
