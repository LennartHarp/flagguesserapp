defmodule Flagguesserapp.Repo.Migrations.UpdateContinentEnum do
  use Ecto.Migration

  def change do
    alter table(:flags) do
      remove :continent
      add :continent, :string, null: false, default: "europe"
    end
  end
end
