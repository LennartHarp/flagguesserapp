defmodule Flagguesserapp.Repo.Migrations.RemoveContinentFromFlags do
  use Ecto.Migration

  def change do
    alter table(:flags) do
      remove :continent
    end
  end
end
