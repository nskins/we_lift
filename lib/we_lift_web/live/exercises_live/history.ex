defmodule WeLiftWeb.ExerciseLive.History do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <.header>Exercise History</.header>

    <.input
      id="exercise_input"
      name="exercise_input"
      value={109}
      errors={[]}
      type="select"
      options={@exercises}
    />
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    exercises =
      Workouts.list_exercises()
      |> Sort.alphabetically(& &1.name)
      |> Enum.map(fn e -> {e.name, e.id} end)

    {:ok,
     socket
     |> assign(:exercises, exercises)}
  end
end
