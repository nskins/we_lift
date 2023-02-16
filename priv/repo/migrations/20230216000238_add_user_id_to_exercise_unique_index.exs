defmodule WeLift.Repo.Migrations.AddUserIdToExerciseUniqueIndex do
  use Ecto.Migration

  def change do
    drop unique_index(:exercises, [:name])

    create unique_index(:exercises, [:name, :user_id])
  end
end
