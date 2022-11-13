defmodule WeLift.Repo.Migrations.AddFinishedAtToWorkout do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add :finished_at, :naive_datetime
    end
  end
end
