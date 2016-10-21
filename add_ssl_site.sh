#!/bin/bash

cd /root/certbot; ./certbot-auto certonly --webroot -n --agree-tos -w /tmp -d $1

/letsencrypt_retrieve_keys.sh
