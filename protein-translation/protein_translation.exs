defmodule ProteinTranslation do
  @codon_to_amino_acid %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
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
    case Map.fetch(@codon_to_amino_acid, codon) do
      :error -> {:error, "invalid codon"}
      value -> value
    end
  end
end
