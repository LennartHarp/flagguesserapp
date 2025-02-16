defmodule Flagguesserapp.Flags.Flag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flags" do
    field :name, :string
    field :continent, :string
    field :image_path, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag, attrs) do
    flag
    |> cast(attrs, [:name, :continent, :image_path])
    |> validate_required([:name, :continent, :image_path])
    |> unique_constraint(:name)
  end
end
