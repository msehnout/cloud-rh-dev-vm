set -e

pushd /home/vagrant/insights-proxy

sed -i s/RUNNER=docker/RUNNER=podman/g scripts/env.sh
sed -i s#REALPATH:/config/spandx.config.js#REALPATH:/spandx.config.js#g scripts/run.sh
sudo scripts/patch-etc-hosts.sh
sudo scripts/update.sh
export SPANDX_CONFIG=/home/vagrant/insights-frontend-starter-app/config/prod.webpack.config.js
sudo -E scripts/run.sh
