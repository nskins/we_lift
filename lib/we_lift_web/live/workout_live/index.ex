defmodule WeLiftWeb.WorkoutLive.Index do
  use WeLiftWeb, :live_view

  alias WeLift.Workouts
  alias WeLift.Workouts.Set

  def render(assigns) do
    ~H"""
    <.button phx-click='finish_workout'>Finish Workout</.button>
    
    <div>or</div>

    <.header>Do Another Set</.header>
    
    <.simple_form
      :let={f}
      for={@changeset}
      id="do_a_set_form"
      phx-submit="do_a_set"
      phx-change="validate"
    >
      <.error :if={@changeset.action == :insert}>
        Oops, something went wrong! Please check the errors below.
      </.error>
      
      <.input field={{f, :exercise_id}} type="select" options={@exercises} required />
      <.input field={{f, :weight_in_lbs}} label="Weight (lbs.)" required />
      <.input field={{f, :reps}} label="Reps" required />

      <:actions>
        <.button phx-disable-with="Adding...">Finish Set</.button>
      </:actions>
    </.simple_form>

    """
  end

  def mount(params, _session, socket) do
    exercises =
      Workouts.list_exercises()
      |> Enum.map(fn e -> {e.name, e.id} end)
    
    set = %Set{}

    {:ok, 
      socket
      |> assign(:set, set)
      |> assign(:changeset, Workouts.change_set(set))
      |> assign(:exercises, exercises)}
  end

  @impl true
  def handle_event("validate", %{"set" => set_params}, socket) do
    changeset =
      socket.assigns.set
      |> Workouts.change_set(set_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

end
