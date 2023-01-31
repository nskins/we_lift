defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.header>Dashboard</.header>
    <div class="flex flex-col">
      <.link navigate={~p"/workouts"} class="text-blue-500 underline">Workouts</.link>
      <.link navigate={~p"/exercises/history"} class="text-blue-500 underline">
        Exercise History
      </.link>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
