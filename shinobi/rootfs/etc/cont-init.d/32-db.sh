#!/usr/bin/env bashio
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the db settings are configured
# ==============================================================================
# shellcheck disable=SC1091

declare CONFIG
declare host
declare username
declare password
declare database
declare port

CONFIG=$(</opt/shinobi/conf.json)
CONFIG=$(bashio::jq "${CONFIG}" ".db={}")

if bashio::config.true 'mysql'; then
    CONFIG=$(bashio::jq "${CONFIG}" ".databaseType=\"mysql\"")

    host=$(bashio::config 'mysql_host')
    CONFIG=$(bashio::jq "${CONFIG}" ".db.host=\"${host}\"")

    username=$(bashio::config 'mysql_username')
    CONFIG=$(bashio::jq "${CONFIG}" ".db.user=\"${username}\"")

    password=$(bashio::config 'mysql_password')
    CONFIG=$(bashio::jq "${CONFIG}" ".db.password=\"${password}\"")

    database=$(bashio::config 'mysql_database')
    CONFIG=$(bashio::jq "${CONFIG}" ".db.database=\"${database}\"")

    port=$(bashio::config 'mysql_port')
    CONFIG=$(bashio::jq "${CONFIG}" ".db.port=\"${port}\"")
else
    CONFIG=$(bashio::jq "${CONFIG}" ".databaseType=\"sqlite3\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".db.filename=\"/data/shinobi.sqlite\"")
fi

MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")
CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.url=\"mqtt://${MQTT_HOST}\"")
CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.mqtt_options.username=\"${MQTT_USER}\"")
CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.mqtt_options.password=\"${MQTT_PASSWORD}\"")


echo "${CONFIG}" > /opt/shinobi/conf.json
