defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    lowercase = map(?a..?z, shift)
    uppercase = map(?A..?Z, shift)
    mapping = Map.merge(lowercase, uppercase)

    text
    |> String.to_charlist()
    |> Enum.map(&Map.get(mapping, &1, &1))
    |> to_string
  end

  defp map(range, shift) do
    rotated =
      range
      |> Stream.cycle()
      |> Stream.drop(shift)
      |> Enum.take(26)

    range
    |> Enum.zip(rotated)
    |> Map.new()
  end
end
