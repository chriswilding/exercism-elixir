defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list, next \\ [])

  def flatten([head | tail], next) when is_list(head) do
    flatten(head, [tail | next])
  end

  def flatten([head | tail], next) when is_nil(head) do
    flatten(tail, next)
  end

  def flatten([head | tail], next) do
    [head | flatten(tail, next)]
  end

  def flatten([], [head | next]) do
    flatten(head, next)
  end

  def flatten([], []), do: []
end
