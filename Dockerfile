FROM debian:latest
MAINTAINER Tim Herman <tim@belg.be>

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
RUN apt-get install bind9

VOLUME /etc/bind/zones/
VOLUME /var/log/named/

EXPOSE 53

add ./entrypoint.sh /entrypoint.sh
run chmod +x /entrypoint.sh

add ./start.sh /start.sh
run chmod +x /start.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash", "/start.sh"]
