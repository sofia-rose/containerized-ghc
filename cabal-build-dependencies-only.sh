#!/usr/bin/env bash

set -eu

# Build the dependencies defined by the cabal.project or *.cabal file
# in the current directory. Then fixup the group permissions for the files
# so that other users in the ghcgroup can use the pre-built packages.

cabal build all --dependencies-only
chgrp --recursive ghcgroup /opt/ghc \
chmod --recursive g=u /opt/ghc
