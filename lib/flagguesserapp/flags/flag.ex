defmodule Flagguesserapp.Flags.Flag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flags" do
    field :name, :string

    field :image_path, :string

    belongs_to :region, Flagguesserapp.Regions.Region

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag, attrs) do
    flag
    |> cast(attrs, [:name, :image_path, :region_id])
    |> validate_required([:name, :image_path, :region_id])
    |> unique_constraint(:name)
    |> assoc_constraint(:region)
  end
end
