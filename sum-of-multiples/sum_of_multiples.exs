defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(_, []), do: 0

  def to(limit, factors) do
    factors
    |> Enum.flat_map(fn factor ->
      Enum.filter(1..(limit - 1), &(rem(&1, factor) === 0))
    end)
    |> MapSet.new()
    |> Enum.sum()
  end
end
