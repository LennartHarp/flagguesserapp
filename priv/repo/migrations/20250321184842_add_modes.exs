defmodule Flagguesserapp.Repo.Migrations.AddModes do
  use Ecto.Migration

  def change do
    create table(:modes) do
      add :name, :string
      add :slug, :string
      add :image_path, :string, default: "/images/placeholder.jpg"

      timestamps(type: :utc_datetime)
    end

    create unique_index(:modes, [:slug])
    create unique_index(:modes, [:name])
  end
end
