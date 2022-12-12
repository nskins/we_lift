defmodule WeLiftWeb.DashboardLive do
  use WeLiftWeb, :live_view

  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.header>Dashboard</.header>

    <.button phx-click="start_workout">Start New Workout</.button>
    
    <%= for workout <- @workouts do %>
      <.workout workout={workout} />
    <% end %>

    <.table id="workouts" rows={@workouts}>
      <:col :let={workout} label="date"><%= WeLift.Date.prettify(workout.inserted_at) %></:col>
      <:col :let={workout} label="finished"><%= finished_status(workout) %></:col>
      <:col :let={workout} label="show">
        <.button phx-click={show_workout(workout)}>Show</.button>
      </:col>
      <:col :let={workout} label="edit">
        <.button phx-click={edit_workout(workout)}>Edit</.button>
      </:col>
    </.table>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts(socket.assigns.current_user)

    {:ok, socket |> assign(:workouts, workouts)}
  end

  @impl true
  def handle_event("start_workout", _params, socket) do
    {:ok, workout} = Workouts.create_workout(socket.assigns.current_user)

    {:noreply,
     socket
     |> redirect(to: ~p"/workouts/#{workout.id}/edit")}
  end
  
  defp workout(assigns) do
    ~H"""
      <div class='m-4'>
        <div><%= WeLift.Date.prettify(@workout.inserted_at) %></div>
        <div class='flex flex-row'>
          <div class='grow'><%= finished_status(@workout) %></div>
          <div class='flex flex-row'>
            <Heroicons.eye solid class="h-5 w-5" phx-click={show_workout(@workout)} />
            <Heroicons.pencil solid class="h-5 w-5" phx-click={edit_workout(@workout)} />
          </div>
        </div>
      </div>
    """
  end

  defp edit_workout(workout) do
    JS.navigate(~p"/workouts/#{workout.id}/edit")
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
