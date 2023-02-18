defmodule WeLiftWeb.ExerciseLive.History do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.back navigate={~p"/dashboard"}>Back to Dashboard</.back>

    <.header>Exercise History</.header>

    <form phx-change="input_changed" id="exercise_history_form">
      <.input
        id="exercise_input"
        name="exercise_input"
        value={@selected_exercise_id}
        errors={[]}
        type="select"
        options={@exercises}
      />

      <.input
        id="duration_input"
        name="duration_input"
        value={@selected_duration}
        errors={[]}
        type="select"
        options={@durations}
      />
    </form>

    <.chart sets={@sets} />
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    exercises =
      Workouts.list_exercises(socket.assigns.current_user)
      |> Sort.alphabetically(& &1.name)
      |> Enum.map(fn e -> {e.name, e.id} end)

    {_, selected_exercise_id} = Enum.at(exercises, 0)

    durations = [
      "One month": 1,
      "Three months": 3,
      "Six months": 6,
      "One year": 12
    ]

    {_, selected_duration} = Enum.at(durations, 0)

    sets = reload_sets(socket.assigns.current_user.id, selected_exercise_id, selected_duration)

    {:ok,
     socket
     |> assign(:exercises, exercises)
     |> assign(:selected_exercise_id, selected_exercise_id)
     |> assign(:durations, durations)
     |> assign(:selected_duration, selected_duration)
     |> assign(:sets, sets)}
  end

  @impl true
  def handle_event(
        "input_changed",
        %{"duration_input" => new_duration_value, "exercise_input" => new_exercise_value},
        socket
      ) do
    new_duration = String.to_integer(new_duration_value)
    new_exercise_id = String.to_integer(new_exercise_value)

    {:noreply,
     socket
     |> assign(:selected_duration, new_duration)
     |> assign(:selected_exercise_id, new_exercise_id)
     |> assign(
       :sets,
       reload_sets(
         socket.assigns.current_user.id,
         new_exercise_id,
         new_duration
       )
     )}
  end

  defp chart(assigns) do
    ~H"""
    <%= chart_svg(@sets) %>
    """
  end

  defp chart_svg(sets) do
    case sets do
      [] ->
        "Not enough data available."

      [_] ->
        "Not enough data available."

      _ ->
        sets
        |> Contex.Dataset.new()
        |> Contex.Plot.new(Contex.PointPlot, 600, 400, mapping: %{x_col: :date, y_cols: [:min, :max]}, smoothed: false)
        |> Contex.Plot.to_svg()
    end
  end

  defp reload_sets(user_id, exercise_id, duration) do
    Workouts.get_historical_sets_by_exercise(user_id, exercise_id, duration)
  end
end
