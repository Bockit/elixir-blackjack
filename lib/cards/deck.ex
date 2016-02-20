defmodule Cards.Deck do
  alias Cards.Card

  @suits [:diamonds, :clubs, :hearts, :spades]
  @values [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :king, :queen, :ace]

  def build_deck(suits \\ @suits, values \\ @values) do
    for suit <- suits, value <- values, do: %Card{suit: suit, value: value}
  end

  def build_deck_with_jokers(suits \\ @suits, values \\ @values) do
    Enum.append(build_deck(suits, values), jokers)
  end

  defp jokers do
    joker = %Card{value: 'Joker'}
    [joker, joker]
  end

  def shuffle_deck(deck, seed \\ :os.timestamp) do
    :random.seed(seed)
    Enum.shuffle(deck)
  end

  def deal([]), do: {:error, "Empty deck"}
  def deal([card | deck]), do: {:ok, card, deck}
end