defmodule NpWeb.Router do
  use NpWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NpWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NpWeb do
    pipe_through :browser # Use the default browser stack

    resources "/login",            SessionController, only: [:new, :create, :delete]
    get "/",                       PageController, :index
    get "/page/:number",           PageController, :page
    get "/album/index",            AlbumController, :index
    get "/album/new",              AlbumController, :new
    post "/album/new",             AlbumController, :create
    get "/album/:hash",            AlbumController, :show
    get "/album/:hash/delete",     AlbumController, :delete
    get "/album/:hash/:slug",      AlbumController, :show
    get "/album/:hash/:slug/edit", AlbumController, :edit
    put "/album/:hash",            AlbumController, :update
  end

  scope "/admin", NpWeb do
    pipe_through :browser

    resources "/album", AdminController, only: [:new, :create, :delete, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NpWeb do
  #   pipe_through :api
  # end
end
