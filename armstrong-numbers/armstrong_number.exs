defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec is_valid?(integer) :: boolean
  def is_valid?(number) do
    number_of_digits = trunc(:math.floor(:math.log10(number) + 1))
    is_valid?(number, number_of_digits, number_of_digits) === number
  end

  defp is_valid?(number, number_of_digits, n, total \\ 0) do
    if n < 1 do
      total
    else
      nth_digit = trunc(rem(number, trunc(:math.pow(10, n))) / trunc(:math.pow(10, n - 1)))

      is_valid?(
        number,
        number_of_digits,
        n - 1,
        total + trunc(:math.pow(nth_digit, number_of_digits))
      )
    end
  end
end
