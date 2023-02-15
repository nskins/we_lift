defmodule WeLiftWeb.WorkoutLive.Edit do
  use WeLiftWeb, :live_view

  alias WeLift.Sort
  alias WeLift.Workouts
  alias WeLift.Workouts.Exercise
  alias WeLift.Workouts.Set

  @impl true
  def render(assigns) do
    ~H"""
    <.back navigate={~p"/workouts"}>Back to Workouts</.back>

    <.simple_form
      :let={f}
      for={@set_changeset}
      id="submit_set_form"
      phx-submit="submit_set"
      phx-change="change_set"
    >
      <.error :if={@set_changeset.action == :insert}>
        Oops, something went wrong! Please check the errors below.
      </.error>

      <div class="flex flex-row overflow-x-scroll">
        <%= for set <- Sort.reverse_chronologically(@workout.sets) do %>
          <.set_box set={set} />
        <% end %>
      </div>

      <.input field={{f, :workout_id}} type="hidden" value={@workout.id} />
      <.input
        id={"submit_set_form_exercise_id_#{length(@exercises)}"}
        field={{f, :exercise_id}}
        type="select"
        options={@exercises}
        value={@selected_exercise_id}
      />

      <.link class="text-blue-700 underline" phx-click="show_modal">
        + Add Custom Exercise
      </.link>

      <.input field={{f, :weight_in_lbs}} label="Weight (lbs.)" autocomplete="off" />
      <.input field={{f, :reps}} label="Reps" autocomplete="off" />

      <:actions>
        <.button phx-disable-with="Adding...">Finish Set</.button>
      </:actions>
    </.simple_form>

    <%= if @show_modal do %>
      <.modal id="new-exercise-modal" show={true} on_cancel={JS.push("hide_modal")}>
        <.live_component
          module={WeLiftWeb.ExerciseLive.NewExerciseComponent}
          id={:new}
          action={@live_action}
          exercise={@exercise}
          current_user={@current_user}
        />
      </.modal>
    <% end %>

    <.button class="mt-7" phx-click="finish_workout">Finish Workout</.button>
    """
  end

  def set_box(assigns) do
    ~H"""
    <div class="p-6">
      <div class="font-bold w-32"><%= @set.exercise.name %></div>
      <div class="w-32"><%= @set.weight_in_lbs %> lbs.</div>
      <div class="w-32"><%= @set.reps %> reps</div>
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

    exercises = load_exercises(socket.assigns.current_user)

    {_, selected_exercise_id} = Enum.at(exercises, 0)

    set = %Set{}

    {:ok,
     socket
     |> assign(:show_modal, false)
     |> assign(:set, set)
     |> assign(:workout, workout)
     |> assign(:set_changeset, Workouts.change_set(set))
     |> assign(:exercise, nil)
     |> assign(:exercises, exercises)
     |> assign(:selected_exercise_id, selected_exercise_id)}
  end

  @impl true
  def handle_event("change_set", %{"set" => set_params}, socket) do
    new_exercise_id = String.to_integer(set_params["exercise_id"])

    set_changeset =
      socket.assigns.set
      |> Workouts.change_set(set_params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:set_changeset, set_changeset)
     |> assign(:selected_exercise_id, new_exercise_id)}
  end

  @impl true
  def handle_event("finish_workout", _params, socket) do
    case Workouts.update_workout(
           socket.assigns.current_user,
           socket.assigns.workout,
           %{
             "finished_at" => NaiveDateTime.utc_now(),
             "user_id" => socket.assigns.current_user.id
           }
         ) do
      {:ok, _workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout finished!")
         |> redirect(to: ~p"/workouts")}

      {:error, %Ecto.Changeset{} = _set_changeset} ->
        {:noreply, socket |> put_flash(:error, "Unable to update Workout!")}
    end
  end

  @impl true
  def handle_event("submit_set", %{"set" => set_params}, socket) do
    case Workouts.create_set(
           socket.assigns.current_user,
           set_params
         ) do
      {:ok, _set} ->
        workout =
          Workouts.get_workout!(
            socket.assigns.current_user,
            socket.assigns.workout.id
          )

        {:noreply, assign(socket, :workout, workout)}

      {:error, %Ecto.Changeset{} = set_changeset} ->
        {:noreply, assign(socket, :set_changeset, set_changeset)}
    end
  end

  @impl true
  def handle_event("show_modal", _params, socket) do
    {:noreply, 
      socket
      |> assign(:exercise, %Exercise{})
      |> assign(:show_modal, true)}
  end

  @impl true
  def handle_event("hide_modal", _params, socket) do
    {:noreply,
      socket
      |> assign(:exercise, nil)
      |> assign(:show_modal, false)}
  end

  @impl true
  def handle_event("change_exercise", %{"exercise" => exercise_params}, socket) do
    exercise_changeset =
      socket.assigns.exercise
      |> Workouts.change_exercise(exercise_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :exercise_changeset, exercise_changeset)}
  end

  @impl true
  def handle_event("submit_exercise", %{"exercise" => exercise_params}, socket) do
    save_exercise(socket, exercise_params)
  end

  defp load_exercises(user) do
    Workouts.list_exercises(user)
    |> Sort.alphabetically(& &1.name)
    |> Enum.map(fn e -> {e.name, e.id} end)
  end

  defp save_exercise(socket, exercise_params) do
    # TODO: check to make sure we don't already have an exercise with the same name.

    case Workouts.create_exercise(socket.assigns.current_user, exercise_params) do
      {:ok, exercise} ->
        exercises = load_exercises(socket.assigns.current_user)
        selected_exercise_id = exercise.id

        {:noreply,
         socket
         |> assign(:exercises, exercises)
         |> assign(:selected_exercise_id, selected_exercise_id)
         |> assign(:show_modal, false)}

      {:error, %Ecto.Changeset{} = exercise_changeset} ->
        {:noreply, assign(socket, exercise_changeset: exercise_changeset)}
    end
  end
end
