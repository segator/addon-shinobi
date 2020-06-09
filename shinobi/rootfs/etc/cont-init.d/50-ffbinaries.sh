#!/usr/bin/env bashio
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the super user account credentials are configured
# ==============================================================================
# shellcheck disable=SC1091

if bashio::config.true 'ffbinaries'; then
    bashio::log.info "Installing ffbinaries..." && \
    yarn --cwd /opt/shinobi add ffbinaries --silent && \
    yarn --cwd /opt/shinobi install --silent
fi