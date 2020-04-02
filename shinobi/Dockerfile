ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003,DL3016
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r1 \
        g++=9.2.0-r4 \
        jpeg-dev=8-r6 \
        make=4.2.1-r2 \
        npm=12.15.0-r1 \
        openssl-dev=1.1.1d-r3 \
        pkgconf=1.6.3-r0 \
        python2-dev=2.7.16-r3 \
        yarn=1.19.2-r0 \
    && apk add --no-cache \
        git=2.24.1-r0 \
        ffmpeg=4.2.1-r3 \
        mysql-client=10.4.12-r0 \
        nodejs=12.15.0-r1 \
        python2=2.7.16-r3 \
        socat=1.7.3.3-r1 \
        sqlite=3.30.1-r1 \
        ttf-freefont=20120503-r1 \
        x264=20191119-r0 \
        x265=3.2.1-r0 \
    && git clone -b master --single-branch \
        https://gitlab.com/Shinobi-Systems/Shinobi.git /opt/shinobi/ \
    && git -C /opt/shinobi checkout abd40e178a06512f8eec87591289903f79a59779 \
    && git -C /opt/shinobi reflog expire --expire=now --all \
    && git -C /opt/shinobi gc --prune=now --aggressive \
    && cd /opt/shinobi \
    && yarn add mysql sqlite3 \
    && yarn install \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Shinobi" \
    io.hass.description="Beautiful and feature-rich CCTV/NVR for your camera's" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Rob Landry <rob@landry.me>" \
    org.label-schema.description="Beautiful and feature-rich CCTV/NVR for your camera's" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Shinobi" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-shinobi-pro/49767?u=frenck" \
    org.label-schema.usage="https://github.com/roblandry/addon-shinobi/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/roblandry/addon-shinobi" \
    org.label-schema.vendor="Community Hass.io Add-ons"
