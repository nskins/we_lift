defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view

  alias WeLift.Workouts

  def render(assigns) do
    ~H"""
      <.header>Dashboard</.header>
    """
  end
end
