defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @encode ~r/([ A-z])\1*/
  @decode ~r/([ A-z])\1*|\d+/

  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(@encode, string, capture: :first)
    |> List.flatten()
    |> List.foldl([], fn match, acc ->
      length = String.length(match)

      if length === 1 do
        [match | acc]
      else
        char = match |> String.graphemes() |> hd
        [char | [length | acc]]
      end
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(@decode, string, capture: :first)
    |> List.flatten()
    |> group
    |> List.foldl([], fn {count, char}, acc ->
      s =
        [char]
        |> Stream.cycle()
        |> Stream.take(count)
        |> Enum.join()

      [s | acc]
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp group(list, acc \\ [])

  defp group([], acc) do
    Enum.reverse(acc)
  end

  defp group([head | tail], acc) do
    case Integer.parse(head) do
      {i, _} -> group(tl(tail), [{i, hd(tail)} | acc])
      :error -> group(tail, [{1, head} | acc])
    end
  end
end
