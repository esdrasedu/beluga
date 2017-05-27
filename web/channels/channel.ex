defmodule Beluga.Channel do
  use Beluga.Web, :channel

  def join(_channel, _params, socket) do
    {:ok, socket}
  end

  def handle_in("init", _params, socket) do
    {:ok, lines} = Beluga.DB.select() |> Beluga.DB.format()
    socket |> push("update", %{lines: lines})
    {:noreply, socket}
  end

end
