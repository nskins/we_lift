defmodule WeLiftWeb.WorkoutLive.Show do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.header>Workout</.header>
    <div><%= WeLift.Date.prettify(@workout.inserted_at) %></div>
    <.table id="sets" rows={Sort.chronologically(@workout.sets)}>
      <:col :let={set} label="exercise"><%= set.exercise.name %></:col>
      <:col :let={set} label="weight_in_lbs"><%= set.weight_in_lbs %></:col>
      <:col :let={set} label="reps"><%= set.reps %></:col>
    </.table>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    workout =
      Workouts.get_workout!(
        socket.assigns.current_user,
        params["id"]
      )

    {:ok,
     socket
     |> assign(:workout, workout)}
  end
end
