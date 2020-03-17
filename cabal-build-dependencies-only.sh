#!/usr/bin/env bash

set -eu

# Build the dependencies defined by the cabal.project or *.cabal file
# in the current directory. Then fixup the group permissions for the files
# so that other users in the ghcgroup can use the pre-built packages.

cabal build all --dependencies-only --enable-tests
find /opt/ghc -user "$(whoami)" -exec chgrp ghcgroup {} +
find /opt/ghc -user "$(whoami)" -exec chmod g=u {} +
find /opt/ghc -user "$(whoami)" -type d -exec chmod g+s {} +
