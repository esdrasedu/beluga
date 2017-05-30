defmodule Beluga.PageController do
  use Beluga.Web, :controller

  alias Beluga.Endpoint

  def index(conn, _params),
    do: conn |> render("index.html")

  def upload(conn, %{"upload" => %{"csv" => %{path: path, content_type: "text/csv"}}}) do

    :ok = Beluga.DB.clean()

    {:ok, results} = path
    |> File.stream!()
    |> CSV.decode()
    |> Beluga.DB.insert()

    {:ok, lines} = results |> Beluga.DB.format()
    {:ok, series, axis} = results |> Beluga.DB.chart()
    filter = Beluga.DB.get_filter()
    |> case do
         [] -> ""
         [filter: filter] when is_bitstring(filter) -> filter
       end

    Endpoint.broadcast!("beluga", "update", %{filter: filter, lines: lines, chart: %{series: series, axis: axis}})

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
