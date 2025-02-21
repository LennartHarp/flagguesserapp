defmodule Flagguesserapp.Regions.Region do
  use Ecto.Schema
  import Ecto.Changeset

  schema "regions" do
    field :name, :string
    field :slug, :string
    field :image_path, :string, default: "/images/placeholder.jpg"

    has_many :flags, Flagguesserapp.Flags.Flag

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name, :slug, :image_path])
    |> validate_required([:name, :slug, :image_path])
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end
end
