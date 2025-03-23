defmodule Flagguesserapp.Modes.Mode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modes" do
    field :name, :string
    field :slug, :string

    field :image_path, :string, default: "/images/placeholder.jpg"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(mode, attrs) do
    mode
    |> cast(attrs, [:name, :slug, :image_path])
    |> validate_required([:name, :slug, :image_path])
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end
end
