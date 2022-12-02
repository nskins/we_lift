defmodule WeLift.Repo.Migrations.AddMoreDefaultExercises do
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
      "Barbell Shrug",
      "Behind-Back Cable Curl",
      "Behind-Neck Pulldown",
      "Bent-Over Lateral Raise",
      "Cable Lying Triceps Extension",
      "Close-Grip Bench Press",
      "Dumbbell Concentration Curl",
      "Dumbbell Flye",
      "Dumbbell Overhead Triceps Extension",
      "Dumbbell Upright Row",
      "Front Squat",
      "Incline Cable Curl",
      "Incline Cable Flye",
      "Leg Press",
      "One-Arm Cable Lateral Raise",
      "One-Arm Smith Machine Shrug",
      "One-Arm Overhead Cable Triceps Extension",
      "Preacher Curl",
      "Reverse-Grip Incline Dumbbell Press",
      "Reverse-Grip Pulldown",
      "Seated Cable Row",
      "Seated Leg Curl",
      "Smith Machine Upright Row"
    ]
  end
end
