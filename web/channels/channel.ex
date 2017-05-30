defmodule Beluga.Channel do
  use Beluga.Web, :channel

  def join(_channel, _params, socket) do
    {:ok, socket}
  end

  def handle_in("init", _params, socket) do
    results = Beluga.DB.select()
    {:ok, lines} = results |> Beluga.DB.format()
    {:ok, series, axis} = results |> Beluga.DB.chart()
    filter = Beluga.DB.get_filter()
    |> case do
         [] -> ""
         [filter: filter] when is_bitstring(filter) -> filter
       end
    socket |> push("update", %{filter: filter, lines: lines, chart: %{series: series, axis: axis}})
    {:noreply, socket}
  end

  def handle_in("filter", filter, socket) do
    filter = filter
    |> case do
         filter when is_bitstring(filter) -> filter
         _ -> ""
       end
    results = Beluga.DB.select(filter)
    {:ok, lines} = results |> Beluga.DB.format()
    {:ok, series, axis} = results |> Beluga.DB.chart()

    socket |> broadcast!("update", %{filter: filter, lines: lines, chart: %{series: series, axis: axis}})
    {:noreply, socket}
  end

end
