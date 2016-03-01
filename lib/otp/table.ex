defmodule Blackjack.Otp.Table do
  use GenServer

  def start_link (id) do
    GenServer.start_link(__MODULE__, id)
  end

  def init(id) do
    deck = Blackjack.Otp.Deck.start_link(5)
    dealer = Blackjack.Otp.Dealer.start_link

    state = %{
      id: id,
      deck: deck,
      dealer: dealer,
    }

    {:ok, state}
  end
end
