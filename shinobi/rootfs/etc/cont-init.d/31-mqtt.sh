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

CONFIG=$(</opt/shinobi/conf.json)
if bashio::config.true 'mqtt'; then
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt={}")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.mqtt_options={}")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage={}")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.triggerTopics={}")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.filterplugs=[]")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.triggerTopics.motionsensor/pir1/out={}")
    host=$(bashio::services mqtt "host")
    username=$(bashio::services mqtt "username")
    password=$(bashio::services mqtt "password")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.url=\"mqtt://${host}\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.mqtt_options.username=\"${username}\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.mqtt_options.password=\"${password}\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.topic=\"shinobi\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.filterplugs+=\"pir1\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.filterplugs+=\"pir2\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.key=\"key\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.name=\"name\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.details=\"details\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.currentTimestamp=\"currentTimestamp\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.plug=\"plug\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.name=\"mon.name\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.triggerTopics.motionsensor/pir1/out.monitorid=\"monitorid\"")
    CONFIG=$(bashio::jq "${CONFIG}" ".mqtt.toMqttMessage.triggerTopics.motionsensor/pir1/out.groupkey=\"groupkey\"")

    cd /opt/shinobi
    mkdir -p libs/customAutoLoad
    curl -o libs/customAutoLoad/mqtt.js https://gitlab.com/geerd/shinobi-mqtt/raw/master/mqtt.js
    yarn add mysql sqlite3 mqtt request moment
else
    CONFIG=$(bashio::jq "${CONFIG}" "del(.mqtt)")
fi

echo "${CONFIG}" > /opt/shinobi/conf.json