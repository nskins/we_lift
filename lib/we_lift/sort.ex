defmodule WeLift.Sort do
  def alphabetically(list, field_selector) do
    Enum.sort(list, &(field_selector.(&1) <= field_selector.(&2)))
  end

  def chronologically(list) do
    Enum.sort(list, &(NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) == :lt))
  end

  def reverse_chronologically(list) do
    Enum.sort(list, &(NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) == :gt))
  end
end
