set -e

pushd /home/vagrant

pushd insights-proxy
npm install
bash scripts/update.sh
popd

pushd insights-chrome
npm install
npm run build
popd

pushd insights-frontend-starter-app
npm install
popd
