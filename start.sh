#!/usr/bin/env bash

mix local.hex --force
mix local.rebar --force

mix deps.get
mix ecto.reset
cd assets && npm i
mix phx.digest
mix phx.server
