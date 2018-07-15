defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    digits =
      isbn
      |> String.to_charlist()
      |> Enum.filter(&(&1 in ?0..?9))
      |> Enum.map(&(&1 - ?0))
      |> Enum.reverse()

    with_check_digit =
      if String.ends_with?(isbn, "X") do
        [10 | digits]
      else
        digits
      end

    valid?(with_check_digit)
  end

  defp valid?(isbn) when length(isbn) == 10 do
    isbn
    |> Enum.with_index(1)
    |> Enum.map(fn {digit, index} -> digit * index end)
    |> Enum.sum()
    |> rem(11) == 0
  end

  defp valid?(isbn), do: false
end
