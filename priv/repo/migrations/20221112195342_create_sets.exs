defmodule WeLift.Repo.Migrations.CreateSets do
  use Ecto.Migration

  def change do
    create table(:sets) do
      add :weight_in_lbs, :integer
      add :reps, :integer
      add :workout_id, references(:workouts, on_delete: :nothing)
      add :exercise_id, references(:exercises, on_delete: :nothing)

      timestamps()
    end

    create index(:sets, [:workout_id])
    create index(:sets, [:exercise_id])
  end
end
