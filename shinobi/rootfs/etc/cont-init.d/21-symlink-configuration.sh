#!/usr/bin/env bashio
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Created a symlink of the persistent stored config to the location Shinobi
# expects it to be.
# ==============================================================================
# shellcheck disable=SC1091

ln -s /data/conf.json /opt/shinobi/conf.json
ln -s /data/super.json /opt/shinobi/super.json
