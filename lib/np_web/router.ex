defmodule NpWeb.Router do
  use NpWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NpWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/page/:number", PageController, :page
    get "/album/index",       AlbumController, :index
    get "/album/new",         AlbumController, :new
    post "/album/new",        AlbumController, :create
    get "/album/:hash",       AlbumController, :show
    get "/album/:hash/:slug", AlbumController, :show
    get "/album/:hash/:slug/edit", AlbumController, :edit
    patch "/album/:hash",   AlbumController, :update
    delete "/album/:hash",  AlbumController, :delete
  end

  scope "/admin", NpWeb do
    pipe_through :browser
  end

  # Other scopes may use custom stacks.
  # scope "/api", NpWeb do
  #   pipe_through :api
  # end
end
