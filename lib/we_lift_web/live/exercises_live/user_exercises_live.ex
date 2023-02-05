defmodule WeLiftWeb.UserExercisesLive do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.back navigate={~p"/dashboard"}>Back to Dashboard</.back>

    <.header>Custom Exercises</.header>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end 
end
