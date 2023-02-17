defmodule WeLiftWeb.ExerciseLive.NewExerciseComponent do
  use WeLiftWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h2>Add Custom Exercise</h2>
      <.simple_form
        :let={f}
        id="submit_exercise_form"
        for={@exercise_changeset}
        phx-change="change_exercise"
        phx-submit="submit_exercise"
      >
        <.error :if={@exercise_changeset.action == :insert}>
          Oops, something went wrong! Please check the errors below.
        </.error>

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
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end
end
