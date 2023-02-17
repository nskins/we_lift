defmodule WeLift.WorkoutsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WeLift.Workouts` context.
  """

  @doc """
  Generate a workout.
  """
  def workout_fixture(attrs \\ %{}) do
    %{"user" => user} = attrs

    {:ok, workout} = WeLift.Workouts.create_workout(user)

    workout
  end
end
