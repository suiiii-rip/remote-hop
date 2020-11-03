#!/bin/bash
set -e
set -x

sshdOrgImage=linuxserver/openssh-server
configFile=./sshd_config.tmp
tmpContainer=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

declare -A params=( ['AllowTcpForwarding']='yes' \
                    ['AllowStreamLocalForwarding']='yes' \
                    ['PermitTunnel']='yes' \
                    ['GatewayPorts']='yes' \
                    ['PermitOpen']='any' \
                  )

docker create --name $tmpContainer $sshdOrgImage
docker cp $tmpContainer:/etc/ssh/sshd_config $configFile
docker rm $tmpContainer

for param in "${!params[@]}"; do
  sed -i "/^$param/d" $configFile;
  echo "$param ${params[$param]}" >> $configFile
done
