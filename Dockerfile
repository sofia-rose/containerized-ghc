FROM debian:buster-20200224

RUN apt-get update \
 && apt-get install -y \
    curl \
    g++ \
    gcc \
    git \
    libgmp-dev \
    libnuma-dev \
    libtinfo-dev\
    libtinfo5 \
    libz-dev \
    make \
    sudo \
    xz-utils

ARG GHCUP_VERSION=0.0.8
ARG GHC_VERSION=8.6.5
ARG CABAL_VERSION=3.0.0.0

ADD ghc-vars.sh /etc/profile.d/ghc-vars.sh
ADD ghcup-${GHCUP_VERSION} /usr/local/bin/ghcup
ADD cabal-build-dependencies-only.sh /usr/local/bin/cabal-build-dependencies-only
RUN chmod +x /usr/local/bin/ghcup \
 && chmod +x /usr/local/bin/cabal-build-dependencies-only \
 && mkdir /opt/ghc \
 && echo '. /etc/profile.d/ghc-vars.sh' >> /etc/bash.bashrc \
 && . /etc/profile.d/ghc-vars.sh \
 && ghcup install ${GHC_VERSION} \
 && ghcup set ${GHC_VERSION} \
 && ghcup install-cabal ${CABAL_VERSION} \
 && cabal update \
 && groupadd ghcgroup \
 && usermod --append --groups ghcgroup root \
 && chgrp --recursive ghcgroup /opt/ghc \
 && chmod --recursive g=u /opt/ghc \
 && find /opt/ghc -type d -exec chmod g+s {} +
