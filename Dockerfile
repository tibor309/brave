FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL release_channel="beta"
LABEL org.opencontainers.image.authors="Tibor (https://github.com/tibor309)"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Brave"
LABEL org.opencontainers.image.description="Web accessible Brave browser."
LABEL org.opencontainers.image.source="https://github.com/tibor309/brave"
LABEL org.opencontainers.image.url="https://github.com/tibor309/brave/packages"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.documentation="https://github.com/tibor309/brave/blob/main/README.md"
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-chromium/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"
ENV TITLE="Brave Beta"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/brave/brave_beta_logo_128x128.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/brave/brave_beta_icon_32x32.ico && \
  echo "**** install packages ****" && \
  curl -fsSLo \
    /usr/share/keyrings/brave-browser-beta-archive-keyring.gpg \
    https://brave-browser-apt-beta.s3.brave.com/brave-browser-beta-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-beta-archive-keyring.gpg] https://brave-browser-apt-beta.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-beta.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    brave-keyring \
    brave-browser-beta && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config