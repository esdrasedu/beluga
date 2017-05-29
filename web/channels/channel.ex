defmodule Beluga.Channel do
  use Beluga.Web, :channel

  def join(_channel, _params, socket) do
    {:ok, socket}
  end

  def handle_in("init", _params, socket) do
    results = Beluga.DB.select()
    {:ok, lines} = results |> Beluga.DB.format()
    {:ok, series, axis} = results |> Beluga.DB.chart()
    socket |> push("update", %{lines: lines, chart: %{series: series, axis: axis}})
    {:noreply, socket}
  end

end
