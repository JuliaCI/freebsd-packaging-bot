#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "ERROR: Expecting 1 argument to setup.sh"
    exit 1
fi

BB_WORKER_NAME="$1"

# Install the stuff needed for the test or build environment
if [ ! -z "$(echo "${BB_WORKER_NAME}" | grep tabularasa)" ]; then
    pkg install -y python git curl
else
    pkg install -y python git curl gmake cmake gcc pkgconf m4 ccache
fi

python -m ensurepip

# Now set up the buildbot environment
pip install buildbot-worker

BB_SERVER="build.julialang.org"
BB_PORT=9989
# source secret.env for the password
source ./secret.env

buildbot-worker create-worker --keepalive=100  --umask 022 worker \
    ${BB_SERVER}:${BB_PORT} ${BB_WORKER_NAME} ${BB_PASSWORD}

echo "Elliot Saba <staticfloat@gmail.com>" > worker/info/admin
echo "Julia ${BB_WORKER_NAME} buildworker" > worker/info/host

# Work around permissions issues using buildbot commands as the vagrant user
chown -R vagrant:vagrant /home/vagrant
