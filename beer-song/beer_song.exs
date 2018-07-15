defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    bottle = "#{quantity(number)} #{container(number)}"

    next_bottle_number = next(number)
    next_bottle = "#{quantity(next_bottle_number)} #{container(next_bottle_number)}"

    """
    #{String.capitalize(bottle)} of beer on the wall, #{bottle} of beer.
    #{action(number)}, #{next_bottle} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @spec action(integer) :: String.t()
  defp action(0), do: "Go to the store and buy some more"
  defp action(1), do: "Take it down and pass it around"
  defp action(_), do: "Take one down and pass it around"

  @spec container(integer) :: String.t()
  defp container(1), do: "bottle"
  defp container(_), do: "bottles"

  @spec quantity(integer) :: String.t()
  defp quantity(0), do: "no more"
  defp quantity(number), do: Integer.to_string(number)

  @spec next(integer) :: integer
  defp next(0), do: 99
  defp next(number), do: number - 1
end
