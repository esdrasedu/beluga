defmodule Beluga.Router do
  use Beluga.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", Beluga do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", PageController, :upload
  end

end
