defmodule WeLift.Workouts.Set do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sets" do
    field :reps, :integer
    field :weight_in_lbs, :integer
    
    belongs_to :exercise, WeLift.Workouts.Exercise
    belongs_to :workout, WeLift.Workouts.Workout

    timestamps()
  end

  @doc false
  def changeset(set, attrs) do
    set
    |> cast(attrs, [:weight_in_lbs, :reps, :workout_id, :exercise_id])
    |> validate_required([:weight_in_lbs, :reps, :workout_id, :exercise_id])
  end
end
