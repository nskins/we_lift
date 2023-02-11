defmodule WeLiftWeb.ExerciseLive.NewExerciseComponent do
  use WeLiftWeb, :live_component

  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h2><%= @title %></h2>
      <.simple_form :let={f} for={:exercise} phx-change="validate" phx-submit="save">
        <.input field={{f, :name}} />
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{exercise: exercise} = assigns, socket) do
    changeset = Workouts.change_exercise(exercise)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"exercise" => exercise_params}, socket) do
    changeset =
      socket.assigns.exercise
      |> Workouts.change_exercise(exercise_params)
      |> Map.put(:action, :validate)

    # TODO: check to make sure we don't already have an exercise with the same name.
    
    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"exercise" => exercise_params}, socket) do
    save_exercise(socket, exercise_params)
  end

  defp save_exercise(socket, exercise_params) do
    user_id = socket.assigns.current_user.user_id

    case Workouts.create_exercise(user_id, exercise_params) do
      {:ok, _exercise} ->
        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
