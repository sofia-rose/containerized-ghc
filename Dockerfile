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

ARG GHCUP_VERSION

ADD ghcup-${GHCUP_VERSION} /usr/local/bin/ghcup
RUN chmod +x /usr/local/bin/ghcup


ARG USER_ID
ARG GROUP_ID

RUN useradd \
    --create-home \
    --shell /bin/bash \
    --uid ${USER_ID} \
    --gid ${GROUP_ID} \
    theuser \
 && echo "theuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER theuser
ENV HOME /home/theuser
ENV PATH $HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH

ARG GHC_VERSION
ARG CABAL_VERSION

RUN ghcup install ${GHC_VERSION} \
 && ghcup set ${GHC_VERSION} \
 && ghcup install-cabal ${CABAL_VERSION} \
 && cabal update

WORKDIR /home/theuser/workspace
