defmodule WeLift.Workouts do
  @moduledoc """
  The Workouts context.
  """

  import Ecto.Query, warn: false
  alias WeLift.Repo
  
  alias WeLift.Workouts.Exercise
  alias WeLift.Workouts.Set
  alias WeLift.Workouts.Workout

  @doc """
  Creates a set.

  Raises `MatchError` if the User is not authorized
  to create a Set for this Workout.

  ## Examples

      iex> create_set(%{id: 5}, %{field: value})
      {:ok, %Set{}}

      iex> create_set(%{id: 5}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
      
      iex> create_set(%{id: 6}, %{field: value})
      ** (MatchError)

  """
  def create_set(user, attrs \\ %{}) do
    user_id = user.id

    # This verifies that the User has permission to
    # create a Set for this Workout.    
    %Workout{user_id: ^user_id} = get_workout!(user, attrs["workout_id"])

    %Set{}
      |> Set.changeset(attrs)
      |> Repo.insert()
  end

  @doc """
  Creates a workout.

  ## Examples

      iex> create_workout(%{id: 5})
      {:ok, %Workout{}}

      iex> create_workout(%{id: 5})
      {:error, %Ecto.Changeset{}}

  """
  def create_workout(user) do
    %Workout{}
    |> Workout.changeset(%{user_id: user.id})
    |> Repo.insert()
  end
  
  @doc """
  Returns the list of exercises.

  ## Examples

      iex> list_exercises()
      [%Exercise{}, ...]

  """
  def list_exercises() do
    Repo.all(Exercise)
  end

  @doc """
  Returns a list of workouts for the user.

  ## Examples

      iex> list_workouts(%{id: 5})
      [%Workout{}, ...]

  """
  def list_workouts(user) do
    user_id = user.id
    
    query =
      from w in Workout,
        where: w.user_id == ^user_id

    Repo.all(query)
  end

  @doc """
  Gets a single workout.

  Raises `Ecto.NoResultsError` if the Workout does not exist.

  Raises `MatchError` if the User is not authorized to access the workout.

  ## Examples

      iex> get_workout!(%{id: 5}, 7)
      %Workout{}

      iex> get_workout!(%{id: 5}, 800)
      ** (Ecto.NoResultsError)

      iex> get_workout!(%{id: 5}, 8)
      ** (MatchError)

  """
  def get_workout!(user, id) do
    workout = 
      Repo.get!(Workout, id)
      |> Repo.preload(sets: [:exercise])

    user_id = workout.user_id

    # This verifies that the User has permission to
    # retrieve this Workout.
    %Workout{user_id: ^user_id} = workout

    workout
  end

  @doc """
  Updates a workout.

  Raises `MatchError` if the User is not authorized to update the workout.

  ## Examples

      iex> update_workout(%{id: 5}, workout, %{field: new_value})
      {:ok, %Workout{}}

      iex> update_workout(%{id: 5}, workout, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

      iex> update_workout(%{id: 5}, %{user_id: 6}, %{field: new_value})
      ** (MatchError)

  """
  def update_workout(user, %Workout{} = workout, attrs) do
    user_id = user.id

    # This ensures the original workout belongs to the user.
    %Workout{user_id: ^user_id} = workout

    IO.inspect(attrs)

    # This ensures the user is not trying to update
    # the workout to belong to another user.
    %{"user_id" => ^user_id} = attrs

    workout
    |> Workout.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Upserts an exercise.

  ## Examples

      iex> upsert_exercise(%{name: "Bench Press"})
      {:ok, %Exercise{}}

      iex> upsert_exercise(%{})
      {:error, %Ecto.Changeset{}}

  """
  def upsert_exercise(attrs) do
    %Exercise{}
    |> Exercise.changeset(attrs)
    |> Repo.insert(
        on_conflict: :nothing,
        conflict_target: :name
       )
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking set changes.
  
  ## Examples
      iex> change_set(set)
      %Ecto.Changeset{data: %Set{}}
  
  """
  def change_set(%Set{} = set, attrs \\ %{}) do
    Set.changeset(set, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workout changes.

  ## Examples
    iex> change_workout(workout)
    %Ecto.Changeset{data: %Workout{}}

  """
  def change_workout(%Workout{} = workout, attrs \\ %{}) do
    Workout.changeset(workout, attrs)
  end

end
