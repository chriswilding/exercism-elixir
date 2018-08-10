defmodule Isogram do
  @chars MapSet.new(?a..?z)

  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    chars =
      sentence
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.filter(&MapSet.member?(@chars, &1))

    size =
      chars
      |> MapSet.new()
      |> MapSet.size()

    length(chars) === size
  end
end
