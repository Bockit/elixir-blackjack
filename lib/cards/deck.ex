defmodule Cards.Deck do
  @suits ~W(D C H S)
  @values ~W(2 3 4 5 6 7 8 9 10 J K Q A)

  alias Cards.Card

  def build_deck do
    @suits
    |> Enum.map(&(build_suit(&1, @values)))
    |> Enum.concat
  end

  defp build_suit(suit, values) do
    Enum.map(values, &(%Card{suit: suit, value: &1}))
  end

  def shuffle_deck(deck) do
    :random.seed(:os.timestamp)
    Enum.shuffle(deck)
  end
end