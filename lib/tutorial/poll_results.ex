defmodule Tutorial.PollResults do
  use GenServer

  # Client API

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  # Server callbacks

  @initial_state %{
    "A" => 0,
    "B" => 0,
    "C" => 0,
    "D" => 0
  }

  def init(_) do
    {:ok, @initial_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
