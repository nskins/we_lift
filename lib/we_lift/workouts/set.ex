defmodule WeLift.Workouts.Set do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sets" do
    field :reps, :integer
    field :weight_in_lbs, :integer
    field :workout_id, :id
    field :exercise_id, :id

    timestamps()
  end

  @doc false
  def changeset(set, attrs) do
    set
    |> cast(attrs, [:weight_in_lbs, :reps])
    |> validate_required([:weight_in_lbs, :reps])
  end
end
