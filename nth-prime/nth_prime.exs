defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1 do
    raise(:error)
  end

  def nth(1), do: 2

  def nth(count) do
    3
    |> Stream.iterate(&(&1 + 2))
    |> nth(count - 1, [])
    |> hd
  end

  defp nth(_, 0, primes), do: primes

  defp nth(stream, count, primes) do
    [prime] = Enum.take(stream, 1)
    next_stream = Stream.filter(stream, &(rem(&1, prime) !== 0))
    nth(next_stream, count - 1, [prime | primes])
  end
end
