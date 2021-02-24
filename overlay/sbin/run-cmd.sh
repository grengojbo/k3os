#!/bin/bash

write_log () {
  local message="${1}"
  logger -t "run-cmd" "${message}"
  echo "${message}"
}

write_log "Getting the service using eth0..."
ETH0=$(connmanctl services | awk '{ print $3 }' | while read -r s1; do connmanctl services $s1 | grep -q "eth0" && echo "$s1"; done)

write_log "eth0 is bound to: ${ETH0}"
write_log "Setting up manual net config..."
connmanctl config $ETH0 --ipv4 manual 192.168.100.2 255.255.255.0 192.168.100.1 --nameservers 192.168.100.1
connmanctl config $ETH0 --ipv6 off
write_log "Restarting connman..."
service connman restart
write_log "$(connmanctl services $ETH0)"
write_log "Network setup done."