defmodule WeLift.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do

    field :user_id, :id
    field :finished_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end
end
