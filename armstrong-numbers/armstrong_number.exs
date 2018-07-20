defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec is_valid?(integer) :: boolean
  def is_valid?(number) do
    number_of_digits = trunc(:math.floor(:math.log10(number) + 1))

    digits(number, number_of_digits)
    |> Enum.reduce(0, &(&2 + trunc(:math.pow(&1, number_of_digits)))) === number
  end

  @spec digits(integer, integer) :: [integer]
  defp digits(number, number_of_digits) do
    1..number_of_digits
    |> Enum.map(&nth_digit(number, &1))
  end

  @spec nth_digit(integer, integer) :: integer
  defp nth_digit(number, n) do
    trunc(rem(number, trunc(:math.pow(10, n))) / trunc(:math.pow(10, n - 1)))
  end
end
