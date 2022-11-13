defmodule WeLift.Repo.Migrations.AddUniqueIndexToExerciseName do
  use Ecto.Migration

  def change do
    create unique_index(:exercises, [:name])
  end
end
