defmodule WeLift.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:workouts, [:user_id])
  end
end
