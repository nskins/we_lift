defmodule WeLift.Date do
  @doc ~S"""
  Formats the given `date` into a pretty string.

  ## Examples

      iex> WeLift.Date.prettify(~D[2022-11-20])
      "Nov. 20, 2022 (Sun.)"

      iex> WeLift.Date.prettify(~D[2023-01-04])
      "Jan. 4, 2023 (Wed.)"

  """
  def prettify(date) do
    day_of_week = pretty_day(Date.day_of_week(date))
    month = pretty_month(date.month)

    "#{month} #{date.day}, #{date.year} (#{day_of_week})"
  end

  defp pretty_day(day) do
    case day do
      1 -> "Mon."
      2 -> "Tue."
      3 -> "Wed."
      4 -> "Thu."
      5 -> "Fri."
      6 -> "Sat."
      7 -> "Sun."
    end
  end

  defp pretty_month(month) do
    case month do
      1 -> "Jan."
      2 -> "Feb."
      3 -> "Mar."
      4 -> "Apr."
      5 -> "May"
      6 -> "Jun."
      7 -> "Jul."
      8 -> "Aug."
      9 -> "Sep."
      10 -> "Oct."
      11 -> "Nov."
      12 -> "Dec."
    end
  end
end
