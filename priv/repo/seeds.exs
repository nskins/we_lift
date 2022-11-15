# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WeLift.Repo.insert!(%WeLift.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias WeLift.Workouts

default_exercises = [
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

for exercise <- default_exercises do
  Workouts.upsert_exercise(%{name: exercise})
end
