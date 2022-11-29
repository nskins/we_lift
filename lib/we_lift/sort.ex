defmodule WeLift.Sort do
  def chronologically(list) do
    Enum.sort(list, &(&1.inserted_at <= &2.inserted_at))
  end

  def reverse_chronologically(list) do
    Enum.sort(list, &(&1.inserted_at >= &2.inserted_at))
  end
end
