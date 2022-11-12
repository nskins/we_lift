defmodule WeLift.Workouts do
  @moduledoc """
  The Workouts context.
  """

  import Ecto.Query, warn: false
  alias WeLift.Repo
  
  alias WeLift.Workouts.Set
  alias WeLift.Workouts.Workout

  @doc """
  Creates a workout.

  Raises `MatchError` if the User is not authorized to create the workout.

  ## Examples

      iex> create_workout(%{id: 5}, %{field: value})
      {:ok, %Workout{}}

      iex> create_workout(%{id: 5}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workout(user) do
    %Workout{}
    |> Workout.changeset(%{user_id: user.id})
    |> Repo.insert()
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

end
