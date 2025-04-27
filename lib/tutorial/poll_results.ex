defmodule Tutorial.PollResults do
  use GenServer

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  def vote(option) when option in ["A", "B", "C", "D"] do
    GenServer.cast(__MODULE__, {:vote, option})
  end

  def reset do
    GenServer.cast(__MODULE__, :reset)
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

  def handle_cast({:vote, option}, state) do
    new_state = Map.update!(state, option, &(&1 + 1))
    {:noreply, new_state}
  end

  def handle_cast(:reset, _state) do
    {:noreply, @initial_state}
  end
end
