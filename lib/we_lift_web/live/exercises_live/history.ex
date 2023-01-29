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
      value={@selected_exercise_id}
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

    {_, selected_exercise_id} = Enum.at(exercises, 0)

    {:ok,
     socket
     |> assign(:exercises, exercises)
     |> assign(:selected_exercise_id, selected_exercise_id)}
  end
end
