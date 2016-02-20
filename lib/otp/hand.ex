defmodule Blackjack.Otp.Hand do
  alias Cards.Hand
  use GenServer

  # API
  def start_link() do
    GenServer.start_link(__MODULE__, %Hand{})
  end

  def hand(pid) do
    GenServer.call(pid, :hand)
  end

  def add_face_up(pid, card) do
    GenServer.cast(pid, {:add_face_up, card})
  end

  def add_face_down(pid, card) do
    GenServer.cast(pid, {:add_face_down, card})
  end

  def reveal(pid) do
    GenServer.cast(pid, {:reveal})
  end

  # Server Callbacks
  def handle_call(:hand, _from, hand) do
    {:reply, hand, hand}
  end

  def handle_cast({:add_face_up, card}, hand) do
    {:noreply, Hand.add_face_up(hand, card)}
  end

  def handle_cast({:add_face_down, card}, hand) do
    {:noreply, Hand.add_face_down(hand, card)}
  end

  def handle_cast({:reveal}, hand) do
    {:noreply, Hand.reveal(hand)}
  end
end