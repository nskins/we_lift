defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view


  @impl true
  def render(assigns) do
    ~H"""
    <.header>Dashboard</.header>
    <.link navigate={~p"/workouts"} class="text-blue-500 underline">Workouts</.link>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
 
end
