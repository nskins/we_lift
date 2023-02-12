defmodule WeLiftWeb.ExerciseLive.NewExerciseComponent do
  use WeLiftWeb, :live_component

  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h2>Add Custom Exercise</h2>
      <.simple_form :let={f} for={@exercise_changeset} phx-change="change_exercise" phx-submit="submit_exercise">

        <.input field={{f, :name}} />
        <.input field={{f, :user_id}} type="hidden" value={@current_user.id} />
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{exercise: exercise} = assigns, socket) do
    exercise_changeset = Workouts.change_exercise(exercise)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:exercise_changeset, exercise_changeset)}
  end
end
