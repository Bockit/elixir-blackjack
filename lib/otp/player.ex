defmodule Blackjack.Otp.Player do
  use GenServer

  # API
  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def hands(pid) do
    GenServer.call(pid, :hands) |> Enum.map(&Blackjack.Otp.Hand.hand/1)
  end

  def count_hands(pid) do
    GenServer.call(pid, :hands) |> len
  end

  def hand(pid, index) do
    GenServer.call(pid, :hands) |> Enum.at(index) |> Blackjack.Otp.Hand.hand
  end

  def add_hand(pid) do
    GenServer.cast(pid, :add_hand)
  end

  def reset_hands(pid) do
    GenServer.cast(pid, :add_hand)
    GenServer.cast(pid, :clear_hands)
  end

  # Server Callbacks
  def init(name) do
    state = %{hands: [], name: name}
    {:ok, state}
  end

  def handle_call(:hands, _from, state) do
    {:reply, state.hands, state}
  end

  def handle_cast(:add_hand, state) do
    hand = Blackjack.Otp.Hand.start_link()
    {:noreply, %{name: state.name, hands: [hand | state.hands]}}
  end

  def handle_cast(:clear_hands, state) do
    Enum.map(state.hands, &GenServer.stop/0)
    {:noreply, %{name: state.name, hands: []}}
  end
end
