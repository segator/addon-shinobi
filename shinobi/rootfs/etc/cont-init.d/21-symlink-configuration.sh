#!/usr/bin/env bashio
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Created a symlink of the persistent stored config to the location Shinobi
# expects it to be.
# ==============================================================================
# shellcheck disable=SC1091

if ! bashio::fs.file_exists '/opt/shinobi/conf.json'; then
    ln -s /data/conf.json /opt/shinobi/conf.json
fi

if ! bashio::fs.file_exists '/opt/shinobi/super.json'; then
    ln -s /data/super.json /opt/shinobi/super.json
fi