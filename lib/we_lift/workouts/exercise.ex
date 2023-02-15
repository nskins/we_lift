defmodule WeLift.Workouts.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :name, :string

    belongs_to :user, WeLift.Accounts.User

    has_many :sets, WeLift.Workouts.Set

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
