defmodule Flagguesserapp.Repo.Migrations.UpdateContinentEnum do
  use Ecto.Migration

  def up do
    alter table(:flags) do
      modify :continent, :string
      # Fügen Sie hier weitere Änderungen hinzu, falls nötig
    end
  end

  def down do
    alter table(:flags) do
      # Hier die Umkehrung der Änderungen, falls nötig
      modify :continent, :string
    end
  end
end
