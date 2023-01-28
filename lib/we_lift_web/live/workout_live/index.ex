defmodule WeLiftWeb.WorkoutLive.Index do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.button phx-click="start_workout">Start New Workout</.button>

    <%= for workout <- Sort.reverse_chronologically(@workouts) do %>
      <.workout workout={workout} />
    <% end %>
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
    <div class="m-6">
      <div><%= WeLift.Date.prettify(@workout.inserted_at) %></div>
      <div class="flex flex-row">
        <.workout_status workout={@workout} />
        <div class="flex flex-row">
          <Heroicons.eye solid class="mx-2 h-5 w-5 cursor-pointer" phx-click={show_workout(@workout)} />
          <Heroicons.pencil
            solid
            class="mx-2 h-5 w-5 cursor-pointer"
            phx-click={edit_workout(@workout)}
          />
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

  defp workout_status(assigns) do
    {text, color} = finished_status(assigns.workout)

    assigns =
      assigns
      |> assign(:text, text)
      |> assign(:style, "grow #{color}")

    ~H"""
    <div class={@style}>
      <%= @text %>
    </div>
    """
  end

  defp finished_status(workout) do
    case workout.finished_at do
      nil -> {"Unfinished", "text-red-700"}
      _ -> {"Finished", "text-green-700"}
    end
  end
end
