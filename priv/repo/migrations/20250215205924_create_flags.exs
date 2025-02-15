defmodule Flagguesserapp.Repo.Migrations.CreateFlags do
  use Ecto.Migration

  def change do
    create table(:flags) do
      add :name, :string, null: false
      add :continent, :string, null: false
      add :image_path, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
