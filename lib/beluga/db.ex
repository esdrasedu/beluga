defmodule Beluga.DB do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_args) do
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

  def filter(""), do: [{{:"$1", :"$2", :"$3", :"$4", :"$5"}, [], [:"$_"]}]

  def select, do: select("")
  def select(filters) do
    Beluga.DB
    |> :ets.select(filter(filters))
  end

  def format([{uuid, date, state, metric, value} | tail], acc) do
    obj = %{uuid: uuid, date: format(date), state: state, metric: metric, value: value}
    format(tail, (acc ++ [obj]))
  end
  def format([], acc), do: {:ok, acc}
  def format({day, month, year}), do: "#{day}/#{month}/#{year}"
  def format(rows) when is_list(rows), do: format(rows, [])

  def chart([row | tail], acc) do
    {:ok, acc} = acc |> acc_chart(row)
    tail |> chart(acc)
  end
  def chart([], acc) do
    axis = acc |> Map.keys()
    series = acc
    |> Map.values()
    |> Enum.map(&Enum.to_list/1)
    |> List.flatten()
    |> Enum.group_by(fn({state, _value})-> state end, fn({_state, value})-> value end)
    |> Enum.to_list()
    |> Enum.map(fn({state, data})->
      %{name: state, data: data}
    end)
    {:ok, series, axis}
  end
  def chart(list), do: list |> chart(%{})

  def acc_chart(acc, {_uuid, date_raw, state, metric, value_raw}) do
    date = format(date_raw)
    value = metric
    |> case do
         "Cost" -> -1
         "Revenue" -> 1
       end
       |> Kernel.*(String.to_integer(value_raw))

    states = acc
    |> get_in([date])
    |> case do
         nil -> %{}
         current -> current
       end
    |> Map.put_new(state, 0)

    acc
    |> Map.put(date, states)
    |> get_and_update_in([date, state], &{:ok, &1 + value})
  end

end
