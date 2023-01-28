defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view


  @impl true
  def render(assigns) do
    ~H"""
    <p>Dashboard</p>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
 
end
