#!/bin/bash
set -e

mkdir -p /etc/bind/zones/master
mkdir -p /etc/bind/zones/slave

mv /etc/bind/named.conf* /etc/bind/zones/
echo "include \"/etc/bind/zones/named.conf\";" > /etc/bind/named.conf

sed -i -e"s:include \"/etc/bind/named.conf:include \"/etc/bind/zones/named.conf:g" /etc/bind/zones/named.conf

exec "$@"
