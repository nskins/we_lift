defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view

  alias WeLift.Workouts

  def render(assigns) do
    ~H"""
      <.header>Dashboard</.header>

      <.button phx-click='start_workout'>Start New Workout</.button>

      <.table id="workouts" rows={@workouts}}>
        <:col :let={workout} label="id"><%= workout.id %></:col>
        <:col :let={workout} label="finished"><%= finished_status(workout) %></:col>
        <:col :let={workout} label="action">
          <.button phx-click={show_workout(workout)}>Show</.button>
        </:col>
      </.table>

    """
  end

  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts(socket.assigns.current_user)

    {:ok, socket |> assign(:workouts, workouts)}
  end
  
  def handle_event("start_workout", params, socket) do
    {:ok, workout} = Workouts.create_workout(socket.assigns.current_user)
    
    {:noreply, 
    socket
    |> redirect(to: ~p"/workouts/#{workout.id}/edit")}
  end
  
  defp show_workout(workout) do
    JS.navigate(~p"/workouts/#{workout.id}")
  end

  defp finished_status(workout) do
    case workout.finished_at do
      nil -> "Unfinished"
      _ -> "Finished"
    end
  end
end
