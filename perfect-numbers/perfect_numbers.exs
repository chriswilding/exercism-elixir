defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number > 2 do
    sum = number |> factors() |> Enum.sum()

    cond do
      sum === number -> {:ok, :perfect}
      sum > number -> {:ok, :abundant}
      sum < number -> {:ok, :deficient}
    end
  end

  def classify(1) do
    {:ok, :deficient}
  end

  def classify(2) do
    {:ok, :deficient}
  end

  def classify(_) do
    {:error, "Classification is only possible for natural numbers."}
  end

  defp factors(number) do
    limit = div(number, 2) + 1

    Enum.filter(1..limit, &(rem(number, &1) === 0))
  end
end
