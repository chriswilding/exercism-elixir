defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @actions %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }
  @reverse 16

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    actions =
      @actions
      |> Map.keys()
      |> List.foldl([], fn flag, actions ->
        if (flag &&& code) > 0 do
          [Map.fetch!(@actions, flag) | actions]
        else
          actions
        end
      end)

    if (@reverse &&& code) > 0 do
      actions
    else
      Enum.reverse(actions)
    end
  end
end
