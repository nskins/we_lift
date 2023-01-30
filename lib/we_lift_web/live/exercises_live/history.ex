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
        "One month": "1M",
        "Three months": "3M",
        "Six months": "6M",
        "One year": "1Y"
      ]

    {_, selected_duration} = Enum.at(durations, 0)

    {:ok,
     socket
     |> assign(:exercises, exercises)
     |> assign(:selected_exercise_id, selected_exercise_id)
     |> assign(:durations, durations)
     |> assign(:selected_duration, selected_duration)}
  end
  
  @impl true
  def handle_event("update_exercise_id", %{"value" => new_exercise_value}, socket) do
    
   new_exercise_id = String.to_integer(new_exercise_value) 

    case socket.assigns.selected_exercise_id do
      ^new_exercise_id -> {:noreply, socket}
      _ -> {:noreply, assign(socket, :selected_exercise_id, new_exercise_id)}
    end
  end

  @impl true
  def handle_event("update_duration", %{"value" => new_duration}, socket) do

    case socket.assigns.selected_duration do
      ^new_duration -> {:noreply, socket}
      _ -> {:noreply, assign(socket, :selected_duration, new_duration)}
    end
  end

end
