defmodule WeLift.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do

    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [])
    |> validate_required([])
  end
end
