defmodule WeLift.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string

      timestamps()
    end
  end
end
