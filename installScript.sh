#!/bin/bash
# steamcmd Base Installation Script
#
# Server Files: /mnt/server

SRCDS_APPID=2519830

if [ "${STEAM_USER}" == "" ]; then
    echo -e "steam user is not set.\n"
    exit 1
else
    echo -e "user set to ${STEAM_USER}"
fi

cd /tmp
mkdir -p /mnt/server/steamcmd
curl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd
cd /mnt/server/steamcmd

chown -R root:root /mnt
export HOME=/mnt/server

./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +app_license_request ${STEAMAPPID} +app_update ${SRCDS_APPID} -beta ${STEAMBETA} validate +quit

cd ~/

export STEAMAPPDIR=Steam/steamapps/common/Resonite/Headless

mkdir -p ${STEAMAPPDIR}/Config

curl -sSL -o ${STEAMAPPDIR}/Config/Config.json "https://raw.githubusercontent.com/Resonite-Community-Projects/resonite-pterodactyl/master/Config.json"

echo "done"
