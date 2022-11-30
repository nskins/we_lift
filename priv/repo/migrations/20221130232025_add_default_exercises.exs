defmodule WeLift.Repo.Migrations.AddDefaultExercises do
  use Ecto.Migration
  alias WeLift.Workouts

  def up do
    for exercise <- default_exercises do
      Workouts.upsert_exercise(%{name: exercise})
    end
  end

  def down do
    for exercise <- default_exercises do
      Workouts.delete_exercise(exercise)
    end
  end

  defp default_exercises do
    [
      "Band Roundhouse Elbow",
      "Barbell Curl",
      "Bench Press",
      "Cable Crossover",
      "Cable Crunch",
      "Cable Oblique Crunch",
      "Cable Overhead Triceps Extension",
      "Cable Woodchopper",
      "Crunch",
      "Dumbbell Bent-Over Row",
      "Dumbbell Incline Curl",
      "Dumbbell Lateral Raise",
      "Dumbbell Side Bend",
      "Dumbbell Shoulder Press",
      "Dumbbell Shrug",
      "Hanging Leg Raise",
      "High Cable Rear Delt Fly",
      "Hip Thrust",
      "Incline Bench Press",
      "Incline Dumbbell Flye",
      "Leg Extension",
      "Leg Press Calf Raise",
      "Lying Leg Curl",
      "Lying Triceps Extension",
      "Oblique Crunch",
      "One-Arm Cable Front Raise",
      "One-Arm High Cable Curl",
      "One-Leg Leg Press",
      "Romanian Deadlift",
      "Seated Calf Raise",
      "Squat",
      "Standing Calf Raise",
      "Standing Pulldown",
      "Straight Arm Pulldown",
      "Triceps Pressdown",
      "Wide-Grip Pulldown"
    ]
  end
end
