defmodule TwelveDays do
  @gifts [
           "and a Partridge in a Pear Tree.",
           "two Turtle Doves",
           "three French Hens",
           "four Calling Birds",
           "five Gold Rings",
           "six Geese-a-Laying",
           "seven Swans-a-Swimming",
           "eight Maids-a-Milking",
           "nine Ladies Dancing",
           "ten Lords-a-Leaping",
           "eleven Pipers Piping",
           "twelve Drummers Drumming"
         ]
         |> Enum.with_index()
         |> Enum.map(fn {k, v} -> {v + 1, k} end)
         |> Map.new()

  @oridinals [
               "first",
               "second",
               "third",
               "fourth",
               "fifth",
               "sixth",
               "seventh",
               "eighth",
               "ninth",
               "tenth",
               "eleventh",
               "twelfth"
             ]
             |> Enum.with_index()
             |> Enum.map(fn {k, v} -> {v + 1, k} end)
             |> Map.new()

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    v = [
      "On the ",
      Map.fetch!(@oridinals, number),
      " day of Christmas my true love gave to me, ",
      gift(number)
    ]

    Enum.join(v)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp gift(number, gifts \\ [])

  defp gift(1, []) do
    ["a Partridge in a Pear Tree."]
  end

  defp gift(number, gifts) when number === 0 do
    gifts
    |> Enum.reverse()
    |> Enum.join(", ")
  end

  defp gift(number, gifts) do
    current_gift = Map.fetch!(@gifts, number)
    gift(number - 1, [current_gift | gifts])
  end
end
