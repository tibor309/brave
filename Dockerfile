FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set labels
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.description="Web accessible Brave browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/brave
LABEL org.opencontainers.image.url=https://github.com/tibor309/brave/packages
LABEL org.opencontainers.image.licenses=GPL-3.0

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"
ENV TITLE=Brave

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