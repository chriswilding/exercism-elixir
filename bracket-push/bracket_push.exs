defmodule BracketPush do
  @map %{"[" => "]", "{" => "}", "(" => ")"}
  @left Map.keys(@map)
  @right Map.values(@map)
  @brackets @left ++ @right

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    check_brackets(String.graphemes(str), [])
  end

  defp check_brackets([], []), do: true
  defp check_brackets([], _), do: false
  defp check_brackets([head | tail], []) when head in @right, do: false

  defp check_brackets([head | tail], stack) when head not in @brackets do
    check_brackets(tail, stack)
  end

  defp check_brackets([head | tail], stack) when head in @left do
    check_brackets(tail, [head | stack])
  end

  defp check_brackets([head | tail], stack) when head in @right do
    if head === Map.get(@map, hd(stack)) do
      check_brackets(tail, tl(stack))
    else
      false
    end
  end
end
