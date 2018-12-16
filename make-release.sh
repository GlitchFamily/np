#!/usr/bin/env bash
set -euxo pipefail
export MIX_ENV=prod

mix deps.get
cd assets/
npm set progress=false
npm i
./node_modules/.bin/webpack --mode production
cd ../
mix phx.digest.clean
mix phx.digest
mix release --env=prod
