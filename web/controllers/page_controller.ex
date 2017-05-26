defmodule Beluga.PageController do
  use Beluga.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
