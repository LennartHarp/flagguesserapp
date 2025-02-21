defmodule Flagguesserapp.Flags.Flag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flags" do
    field :name, :string

    field :continent,
          Ecto.Enum,
          values: [:africa, :asia, :europe, :northamerica, :southamerica, :oceania],
          default: :europe

    field :image_path, :string

    belongs_to :region, Flagguesserapp.Regions.Region

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag, attrs) do
    flag
    |> cast(attrs, [:name, :continent, :image_path, :region_id])
    |> validate_required([:name, :continent, :image_path, :region_id])
    |> unique_constraint(:name)
    |> assoc_constraint(:region)
  end
end
