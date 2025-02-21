defmodule Flagguesserapp.Repo.Migrations.AddRegionIdToFlags do
  use Ecto.Migration

  def change do
    alter(table(:flags)) do
      add :region_id, references(:regions)
    end

    create index(:flags, [:region_id])
  end
end
