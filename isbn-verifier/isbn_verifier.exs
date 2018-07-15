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
    numbers =
      isbn
      |> String.to_charlist()
      |> Enum.filter(&(&1 in 48..57))
      |> Enum.map(fn c -> c - 48 end)

    isbn?(numbers, String.ends_with?(isbn, "X"))
  end

  defp isbn?(isbn, true) when length(isbn) == 9 do
    isbn?(isbn ++ [10], true)
  end

  defp isbn?(isbn, _) when length(isbn) == 10 do
    sum =
      Enum.zip(isbn, 10..1)
      |> Enum.reduce(0, fn {digit, index}, acc -> acc + digit * index end)

    rem(sum, 11) == 0
  end

  defp isbn?(isbn, _), do: false
end
