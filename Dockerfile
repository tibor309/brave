FROM ghcr.io/linuxserver/baseimage-selkies:debianbookworm

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL release_channel="stable"
LABEL org.opencontainers.image.authors="Tibor (https://github.com/tibor309)"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Brave"
LABEL org.opencontainers.image.description="Web accessible Brave browser."
LABEL org.opencontainers.image.source="https://github.com/tibor309/brave"
LABEL org.opencontainers.image.url="https://github.com/tibor309/brave/packages"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.documentation="https://github.com/tibor309/brave/blob/main/README.md"
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-selkies:debianbookworm"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-selkies/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Brave"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
  echo "**** install packages ****" && \
  curl -fsSLo \
    /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
  echo \
    "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \ 
    > /etc/apt/sources.list.d/brave-browser-release.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    brave-keyring \
    brave-browser && \
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
