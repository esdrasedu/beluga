defmodule Beluga.DB do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_args) do
    "Init" |> IO.puts()
    Beluga.DB |> :ets.new([:set, :public, :named_table])
    {:ok, nil}
  end

  def clean() do
    true = Beluga.DB |> :ets.delete_all_objects()
    :ok
  end

  def insert(["Date", "State", "Metric", "Value"]),
    do: []
  def insert([date_raw, state, metric, value]) do
    [day, month, year] = date_raw |> String.split("/")
    row = {UUID.uuid1(), {day, month, year}, state, metric, value}
    true = Beluga.DB |> :ets.insert(row)
    row
  end
  def insert(csv) do
    results = csv
    |> Stream.map(&insert/1)
    |> Enum.to_list()
    |> List.flatten()

    {:ok, results}
  end

end
