defmodule ProteinTranslation do
  @codon_to_amino_acid %{
    "UGU" => {:ok, "Cysteine"},
    "UGC" => {:ok, "Cysteine"},
    "UUA" => {:ok, "Leucine"},
    "UUG" => {:ok, "Leucine"},
    "AUG" => {:ok, "Methionine"},
    "UUU" => {:ok, "Phenylalanine"},
    "UUC" => {:ok, "Phenylalanine"},
    "UCU" => {:ok, "Serine"},
    "UCC" => {:ok, "Serine"},
    "UCA" => {:ok, "Serine"},
    "UCG" => {:ok, "Serine"},
    "UGG" => {:ok, "Tryptophan"},
    "UAU" => {:ok, "Tyrosine"},
    "UAC" => {:ok, "Tyrosine"},
    "UAA" => {:ok, "STOP"},
    "UAG" => {:ok, "STOP"},
    "UGA" => {:ok, "STOP"}
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    {status, list} =
      rna
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.take_while(&(of_codon(&1) !== {:ok, "STOP"}))
      |> Enum.reduce({:ok, []}, fn codon, {old_status, acc} ->
        {new_status, output} = of_codon(codon)

        case {old_status, new_status, output} do
          {_, :ok, amino_acid} -> {:ok, [amino_acid | acc]}
          {:error, _, acc} -> {:error, nil}
          {_, :error, acc} -> {:error, nil}
        end
      end)

    case {status, list} do
      {:error, _} -> {:error, "invalid RNA"}
      {_, list} -> {:ok, Enum.reverse(list)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    error = {:error, "invalid codon"}
    Map.get(@codon_to_amino_acid, codon, error)
  end
end
