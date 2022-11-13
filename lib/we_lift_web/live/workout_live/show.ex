defmodule WeLiftWeb.WorkoutLive.Show do
  use WeLiftWeb, :live_view

  alias WeLift.Workouts

  @impl
  def render(assigns) do
    ~H"""
      <.header>Workout</.header>

      <.table id="sets" rows={@workout.sets}>
        <:col :let={set} label="exercise"><%= set.exercise.name %></:col>
        <:col :let={set} label="weight_in_lbs"><%= set.weight_in_lbs %></:col>
        <:col :let={set} label="reps"><%= set.reps %></:col>
      </.table>


    """
  end

  def mount(params, _session, socket) do
    workout = Workouts.get_workout!(
      socket.assigns.current_user, 
      params["id"])
 
    {:ok, 
      socket
      |> assign(:workout, workout)}
  end


end
