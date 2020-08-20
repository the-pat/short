defmodule ShortWeb.Router do
  use ShortWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShortWeb do
    pipe_through :api

    resources "/links", LinkController, except: [:edit]
  end

  scope "/", ShortWeb do
    get "/:id", LinkController, :get_and_redirect
  end
end
