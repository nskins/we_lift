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
    changeset = Workouts.change_exercise(exercise)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end
end
