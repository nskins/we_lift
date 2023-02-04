defmodule WeLiftWeb.WorkoutLive.Show do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.back navigate={~p"/workouts"}>Back to Workouts</.back>
    <.header>Workout</.header>
    <div><%= WeLift.Date.prettify(@workout.inserted_at) %></div>
    <%= for set <- Sort.chronologically(@workout.sets) do %>
      <.set set={set} />
    <% end %>
    """
  end

  defp set(assigns) do
    ~H"""
    <div class="m-6">
      <div class="font-bold"><%= @set.exercise.name %></div>
      <div class="flex flex-row">
        <div class="grow"><%= @set.weight_in_lbs %> lbs. (x<%= @set.reps %>)</div>
        <Heroicons.trash
          solid
          class="mx-2 h-5 w-5 cursor-pointer"
          phx-click="delete_set"
          phx_value_id={@set.id}
          data={[confirm: "Are you sure?"]}
        />
      </div>
    </div>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    workout =
      Workouts.get_workout!(
        socket.assigns.current_user,
        params["id"]
      )

    {:ok,
     socket
     |> assign(:workout, workout)}
  end

  @impl true
  def handle_event("delete_set", %{"id" => id}, socket) do
    Workouts.delete_set(socket.assigns.current_user, id, socket.assigns.workout)

    workout =
      Workouts.get_workout!(
        socket.assigns.current_user,
        socket.assigns.workout.id
      )

    {:noreply, assign(socket, :workout, workout)}
  end
end
