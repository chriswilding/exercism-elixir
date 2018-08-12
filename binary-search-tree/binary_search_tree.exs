defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: data} = node, new_data) do
    if new_data <= data do
      insert_left(node, new_data)
    else
      insert_right(node, new_data)
    end
  end

  defp insert_left(%{left: nil} = node, data) do
    %{node | left: new(data)}
  end

  defp insert_left(%{left: left} = node, data) do
    %{node | left: insert(left, data)}
  end

  defp insert_right(%{right: nil} = node, data) do
    %{node | right: new(data)}
  end

  defp insert_right(%{right: right} = node, data) do
    %{node | right: insert(right, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(%{data: data, left: left, right: right}) do
    in_order(left) ++ [data] ++ in_order(right)
  end
end
