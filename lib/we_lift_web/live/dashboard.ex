defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view

  alias WeLift.Workouts

  def render(assigns) do
    ~H"""
      <.header>Dashboard</.header>

      <.button phx-click='start_workout'>Start New Workout</.button>
    """
  end

  
  def handle_event("start_workout", params, socket) do
    {:ok, workout} = Workouts.create_workout(socket.assigns.current_user)
    
    {:noreply, 
    socket
    |> redirect(to: ~p"/workouts/#{workout.id}/edit")}
  end
end
