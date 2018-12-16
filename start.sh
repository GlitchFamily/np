#!/usr/bin/env bash

set -euxo pipefail

mix local.hex --force
mix local.rebar --force

mix deps.get
mix ecto.reset
mix phx.digest.clean
mix phx.digest
cd assets && npm i && cd ../
mix phx.server
