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
      for={@changeset}
      id="submit_set_form"
      phx-submit="submit_set"
      phx-change="validate"
    >
      <.error :if={@changeset.action == :insert}>
        Oops, something went wrong! Please check the errors below.
      </.error>

      <div class="flex flex-row overflow-x-scroll">
        <%= for set <- Sort.reverse_chronologically(@workout.sets) do %>
          <.set_box set={set} />
        <% end %>
      </div>

      <.input field={{f, :workout_id}} type="hidden" value={@workout.id} />
      <.input field={{f, :exercise_id}} type="select" options={@exercises} />

      <%= live_patch("+ Add Custom Exercise",
        to: ~p"/workouts/#{@workout.id}/edit/exercises",
        class: "text-blue-700 underline p-2"
      ) %>

      <.input field={{f, :weight_in_lbs}} label="Weight (lbs.)" autocomplete="off" />
      <.input field={{f, :reps}} label="Reps" autocomplete="off" />

      <:actions>
        <.button phx-disable-with="Adding...">Finish Set</.button>
      </:actions>
    </.simple_form>

    <%= if @live_action in [:new] do %>
      <.modal id="new-exercise-modal" show={true}>
        <.live_component
          module={WeLiftWeb.ExerciseLive.NewExerciseComponent}
          title={@page_title}
          id={:new}
          action={@live_action}
          exercise={@exercise}
          current_user={@current_user}
          return_to={~p"/workouts/#{@workout.id}/edit"}
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

    exercises =
      Workouts.list_exercises()
      |> Sort.alphabetically(& &1.name)
      |> Enum.map(fn e -> {e.name, e.id} end)

    set = %Set{}

    {:ok,
     socket
     |> assign(:set, set)
     |> assign(:workout, workout)
     |> assign(:changeset, Workouts.change_set(set))
     |> assign(:exercises, exercises)}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action)}
  end

  defp apply_action(socket, :new) do
    socket
    |> assign(:page_title, "Add Custom Exercise")
    |> assign(:exercise, %Exercise{})
  end

  defp apply_action(socket, :edit) do
    socket
    |> assign(:page_title, "Edit Workout")
    |> assign(:exercise, nil)
  end

  @impl true
  def handle_event("validate", %{"set" => set_params}, socket) do
    changeset =
      socket.assigns.set
      |> Workouts.change_set(set_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
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

      {:error, %Ecto.Changeset{} = _changeset} ->
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

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
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
    user_id = socket.assigns.current_user.id

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
