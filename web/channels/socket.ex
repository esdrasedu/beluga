defmodule Beluga.Socket do
  use Phoenix.Socket

  channel "beluga", Beluga.Channel
  transport :websocket, Phoenix.Transports.WebSocket
  def connect(_params, socket), do: {:ok, socket}
  def id(_socket), do: nil
end
