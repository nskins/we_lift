defmodule WeLift.Repo.Migrations.AddExercisesBatch3 do
  use Ecto.Migration
  alias WeLift.Workouts

  def up do
    for exercise <- default_exercises() do
      Workouts.upsert_exercise(%{name: exercise})
    end
  end

  def down do
    for exercise <- default_exercises() do
      Workouts.delete_exercise(exercise)
    end
  end

  defp default_exercises do
    [
      "Bicycle Crunch",
      "Dumbbell Lunge",
      "Good Morning",
      "Hip Abductor",
      "Hip Adductor",
      "Incline Dumbbell Press",
      "Overhead Press",
      "Pull-Up",
      "Push-Up"
    ]
  end
end
