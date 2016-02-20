defmodule Cards.Hand do
  defstruct face_up: [], face_down: []

  def add_face_up(hand, card) do
    Map.put(hand, :face_up, [card | hand.face_up])
  end

  def add_face_down(hand, card) do
    Map.put(hand, :face_down, [card | hand.face_down])
  end

  def reveal(hand) do
    hand
    |> Map.put(:face_down, hand.face_up ++ hand.face_down)
    |> Map.put(:face_up, [])
  end
end