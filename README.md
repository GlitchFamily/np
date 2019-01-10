# Naow Playaaaaaan

## Development requirements:

* Erlang/OTP ≥ 21 (use [kerl](https://github.com/kerl/kerl))
* Elixir ≥ 1.7 (use [kiex](https://github.com/taylor/kiex))
* NPM ≥ 5.6
* Node ≥ 8.11
* PostgreSQL ≥ 10.4

To start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create, migrate and seed your database with `mix ecto.reset`
  * Install Node.js dependencies with `cd assets && npm i`
  * (Prod) Generate an assets digest with `mix phx.digest`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Production

1. Clone the respository
2. Make the release
3. Move the assets to the appropriate location on your filesystem
4. Create the DB
5. Migrate the DB
7. Run the app.

## Credits
  * [Higgcss](https://github.com/robinparisi/higgcss) - The minimal CSS framework
