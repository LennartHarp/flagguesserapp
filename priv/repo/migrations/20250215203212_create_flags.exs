defmodule Flagguesserapp.Repo.Migrations.CreateFlags do
  use Ecto.Migration

  def change do
    create table(:flags) do
      add :name, :string
      add :continent, :string
      add :image_path, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:flags, [:image_path])
    create unique_index(:flags, [:continent])
    create unique_index(:flags, [:name])
  end
end
