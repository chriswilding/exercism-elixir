defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil

  def convert(digits, base_a, base_b) do
    if valid?(digits, base_a) do
      digits
      |> to_base_10(base_a)
      |> to_base_x(base_b)
    else
      nil
    end
  end

  defp valid?(digits, from) do
    Enum.all?(digits, &(&1 >= 0 && &1 < from))
  end

  defp to_base_10(digits, from) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {digit, index} ->
      digit * trunc(:math.pow(from, index))
    end)
    |> Enum.sum()
  end

  defp to_base_x(int, to, digits \\ [])
  defp to_base_x(0, _, []), do: [0]
  defp to_base_x(0, _, digits), do: digits

  defp to_base_x(int, to, digits) do
    quotient = div(int, to)
    remainder = rem(int, to)
    to_base_x(quotient, to, [remainder | digits])
  end
end
