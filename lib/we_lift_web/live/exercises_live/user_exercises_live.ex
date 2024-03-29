defmodule WeLiftWeb.UserExercisesLive do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.back navigate={~p"/dashboard"}>Back to Dashboard</.back>

    <.header>Custom Exercises</.header>

    <%= for exercise <- @exercises do %>
      <div><%= exercise.name %></div>
    <% end %>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    exercises =
      Workouts.get_custom_exercises(socket.assigns.current_user.id)
      |> Sort.alphabetically(& &1.name)

    {:ok,
     socket
     |> assign(:exercises, exercises)}
  end
end
