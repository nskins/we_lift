defmodule WeLift.Repo.Migrations.AddUserIdToExercises do
  use Ecto.Migration

  def change do
    alter table("exercises") do
      add :user_id, references(:users)
    end

    create index(:exercises, [:user_id])
  end
end
