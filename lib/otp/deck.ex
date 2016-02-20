defmodule Blackjack.Otp.Deck do
  alias Cards.Deck
  use GenServer

  # API
  def start_link(num_decks \\ 1) do
    GenServer.start_link(__MODULE__, num_decks)
  end

  def deck(pid) do
    GenServer.call(pid, :deck)
  end

  def deal(pid) do
    GenServer.call(pid, :deal)
  end

  def shuffle(pid) do
    GenServer.cast(pid, :shuffle)
  end

  # Server Callbacks
  def init(num_decks) do
    deck = 0..num_decks - 1
    |> Enum.map(fn(_) -> Deck.build_deck end)
    |> Enum.concat

    {:ok, deck}
  end

  def handle_call(:deck, _from, deck) do
    {:reply, deck, deck}
  end

  def handle_call(:deal, _from, deck) do
    case Deck.deal(deck) do
      {:ok, card, deck} -> {:reply, card, deck}
      {:error, reason} -> {:stop, reason, deck}
    end
  end

  def handle_cast(:shuffle, deck) do
    {:noreply, Deck.shuffle(deck)}
  end
end