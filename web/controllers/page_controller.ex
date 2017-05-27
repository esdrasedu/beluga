defmodule Beluga.PageController do
  use Beluga.Web, :controller

  def index(conn, _params),
    do: conn |> render("index.html")

  def upload(conn, %{"upload" => %{"csv" => %{path: path, content_type: "text/csv"}}}) do

    :ok = Beluga.DB.clean()

    {:ok, _result} = path
    |> File.stream!()
    |> CSV.decode()
    |> Beluga.DB.insert()
    |> IO.inspect()

    conn
    |> render("index.html")
  end

  def upload(conn, _params) do
    conn
    |> put_layout({Beluga.ErrorView, "application.html"})
    |> assign(:message, "Não foi possível carregar o banco, tem certeza que é CSV?")
    |> render("500.html")
  end

end
