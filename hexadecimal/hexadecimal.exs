defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """
  @hex_to_dec %{
    ?0 => 0,
    ?1 => 1,
    ?2 => 2,
    ?3 => 3,
    ?4 => 4,
    ?5 => 5,
    ?6 => 6,
    ?7 => 7,
    ?8 => 8,
    ?9 => 9,
    ?a => 10,
    ?b => 11,
    ?c => 12,
    ?d => 13,
    ?e => 14,
    ?f => 15
  }

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    chars =
      hex
      |> String.downcase()
      |> String.to_charlist()

    valid = Enum.all?(chars, &Map.has_key?(@hex_to_dec, &1))

    if valid do
      chars
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {char, index} ->
        digit = Map.fetch!(@hex_to_dec, char)
        digit * trunc(:math.pow(16, index))
      end)
      |> Enum.sum()
    else
      0
    end
  end
end
