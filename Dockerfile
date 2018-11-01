FROM ubuntu:latest

RUN apt-get update &&  apt-get install -y  wget gnupg
RUN wget http://nginx.org/packages/keys/nginx_signing.key
RUN cat nginx_signing.key | apt-key add - 
RUN echo 'deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx' > /etc/apt/sources.list.d/nginx.list; apt-get update;
RUN apt-get install -y --force-yes psmisc inotify-tools dnsmasq git cron nginx=1.9.15-1~trusty

ADD https://raw.githubusercontent.com/tests-always-included/mo/master/mo /root/mo

RUN cd /root/ && git clone https://github.com/certbot/certbot && cd /root/certbot && ( ./certbot-auto -n || echo )

COPY / /-root-
RUN cp -r /-root-/* /

CMD /run_app nginx

