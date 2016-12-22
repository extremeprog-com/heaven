# Heaven
Nginx container with LetsEncrypt SSL for simple Docker deployments.

## Inspiration
https://www.youtube.com/watch?v=JxPj3GAYYZ0 https://www.youtube.com/watch?v=oW_7XBrDBAA

## Use Cases

- You have containers app1, app2, app-clap, ... You want them to be available as `http(s)://app1.yourdomain.com`, `http(s)://app2.yourdomain.com`, `http(s)://app-clap.yourdomain.com`...

- You have a developer with nick "mr-twister", ... He develops applications app1, app2, app-clap, and you want them to be available as `http://app1.mr-twister.yourdomain.com`, `http://app2.mr-twister.yourdomain.com`, `http://app-clap.mr-twister.yourdomain.com`...

- You want to have a payment-free LetsEncrypt SSL for `https://` support. You dont't have to setup anything – it's fully automated!

- You want to use the same behaviour with Rancher (fully automated), Swarm, ... 


## Installation

#### DNS record
Create `*.yourdomain.com` DNS record, install Heaven and create any container with any name which will be available as `xxx.yourdomain.com`.
  - in case of appN.yurdomain.com you must create * IN A {SERVER_IP_ADDRESS}
  - in case of appN.developerName.yourdomain.com you must create `*.developername` IN A {SERVER_IP_ADDRESS}

#### Docker run

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

#### Check container port
Containers MUST listen port 80 inside them to be exported. That's all!

## Details
By default Heaven routes all requests to all containers. Let's consider container name of your site to be **xxx**.
Heaven will route all requests that come to xxx.any.com, xxx.many.any.com (any zone) to your container on port 80.

Heaven reads additional nginx configurations for your site from `/opt/containers/xxx/nginx` folder. You should just add the file with any name with `.conf` extention. For example, it can be useful if you want heaven to route requests to other port.

After installation your site will be available over `http` or `https` automatically.

### For Rancher-based deployments
We have our own Rancher catalog. You can add it manually to your Rancher and install Heaven stack from there. Further reading https://github.com/extremeprog-com/rancher-catalog.

### Usage with other docker orchestration tools and in distributed environments

Additional ENV variables:

**DNS_RESOLVER={INTERNAL_DNS_SERVER_IP_ADDRESS}** – for translation a container name to IP address. If it's not used, Heaven will run its own dnsmasq server and info from Docker Daemon.

**CONTAINER_DNS_TEMPLATE={DNS_NAME_OF_CONTAINER}** – default `$name.lo` (for using with internal dnsmasq server), `heaven-frontend.$name` (for using with Rancher). $name is a part of a $name.yourdomain.com or $name.developerName.yourdomain.com. 

