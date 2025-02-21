defmodule Flagguesserapp.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions) do
      add :name, :string
      add :slug, :string
      add :image_path, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:regions, [:slug])
    create unique_index(:regions, [:name])
  end
end
