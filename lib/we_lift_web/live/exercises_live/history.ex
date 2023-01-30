defmodule WeLiftWeb.ExerciseLive.History do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.header>Exercise History</.header>

    <.input
      id="exercise_input"
      name="exercise_input"
      value={@selected_exercise_id}
      errors={[]}
      type="select"
      options={@exercises}
      phx-click="update_exercise_id"
    />

    <.input
      id="duration_input"
      name="duration_input"
      value={@selected_duration}
      errors={[]}
      type="select"
      options={@durations}
      phx-click="update_duration"
    />

    <.chart sets={@sets} />
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    exercises =
      Workouts.list_exercises()
      |> Sort.alphabetically(& &1.name)
      |> Enum.map(fn e -> {e.name, e.id} end)

    {_, selected_exercise_id} = Enum.at(exercises, 0)

    durations =
      [
        "One month": 1,
        "Three months": 3,
        "Six months": 6,
        "One year": 12
      ]

    {_, selected_duration} = Enum.at(durations, 0)

    sets = Workouts.get_historical_sets_by_exercise(socket.assigns.current_user.id, selected_exercise_id, selected_duration)
    
    {:ok,
     socket
     |> assign(:exercises, exercises)
     |> assign(:selected_exercise_id, selected_exercise_id)
     |> assign(:durations, durations)
     |> assign(:selected_duration, selected_duration)
     |> assign(:sets, sets)}
  end
  
  @impl true
  def handle_event("update_exercise_id", %{"value" => new_exercise_value}, socket) do
    
   new_exercise_id = String.to_integer(new_exercise_value)

    case socket.assigns.selected_exercise_id do
      ^new_exercise_id -> {:noreply, socket}
      _ -> 
        sets = Workouts.get_historical_sets_by_exercise(socket.assigns.current_user.id, new_exercise_id, socket.assigns.selected_duration)
        {:noreply, socket
                      |> assign(:selected_exercise_id, new_exercise_id)
                      |> assign(:sets, sets)}
    end
  end

  @impl true
  def handle_event("update_duration", %{"value" => new_duration_value}, socket) do

    new_duration = String.to_integer(new_duration_value)

    case socket.assigns.selected_duration do
      ^new_duration -> {:noreply, socket}
      _ -> 
        sets = Workouts.get_historical_sets_by_exercise(socket.assigns.current_user.id, socket.assigns.selected_exercise_id, new_duration)
        {:noreply, socket
                   |> assign(:selected_duration, new_duration)
                   |> assign(:sets, sets)}
    end
  end

  defp chart(assigns) do
    ~H"""
    <%= chart_svg(@sets) %>
    """
  end

  defp chart_svg(sets) do
    case sets do
      [] -> "Not enough data available."
      [_] -> "Not enough data available."
      _ ->
        sets
          |> Enum.map(fn s -> [s.inserted_at, s.weight_in_lbs] end)
          |> Contex.Dataset.new()
          |> Contex.Plot.new(Contex.LinePlot, 600, 400)
          |> Contex.Plot.to_svg()
    end
  end

end
