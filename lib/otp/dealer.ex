defmodule Blackjack.Otp.Dealer do
  use GenServer
  alias Blackjack.Otp.Hand

  # API
  def start_link do
    GenServer.start_link(__MODULE__)
  end

  def empty_hand(pid) do
    GenServer.cast(pid, :empty_hand)
  end

  def hand(pid) do
    GenServer.call(pid, :hand) |> Blackjack.Otp.Hand.hand
  end

  # Server Callbacks
  def init do
    hand = Blackjack.Otp.Hand.start_link
    {:ok, hand}
  end

  def handle_call(:hand, _from, hand) do
    {:reply, hand, hand}
  end

  def handle_cast(:empty_hand, hand) do
    GenServer.stop(hand)
    hand = BlackJack.Otp.Hand.start_link
    {:noreply, hand}
  end
end
