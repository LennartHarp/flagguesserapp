defmodule Flagguesserapp.Regions do
  @moduledoc """
  The Regions context.
  """

  import Ecto.Query, warn: false
  alias Flagguesserapp.Flags.Flag
  alias Flagguesserapp.Repo

  alias Flagguesserapp.Regions.Region

  @doc """
  Returns the list of regions.

  ## Examples

      iex> list_regions()
      [%Region{}, ...]

  """
  def list_regions do
    Repo.all(Region)
  end

  @doc """
  Gets a single region.

  Raises `Ecto.NoResultsError` if the Region does not exist.

  ## Examples

      iex> get_region!(123)
      %Region{}

      iex> get_region!(456)
      ** (Ecto.NoResultsError)

  """

  def get_region!(id_or_slug) do
    case Integer.parse(id_or_slug) do
      {int, ""} -> Repo.get(Region, int)
      _ -> Repo.get_by!(Region, slug: id_or_slug)
    end
  end

  def get_region_with_flags!(id_or_slug) do
    get_region!(id_or_slug) |> Repo.preload(:flags)
  end

  def get_region_with_flags_with_limit!(id_or_slug, limit) do
    get_region!(id_or_slug)
    |> Repo.preload(flags: from(f in Flag, limit: ^limit))
  end

  def region_names_and_ids do
    query =
      from r in Region,
        order_by: :name,
        select: {r.name, r.id}

    Repo.all(query)
  end

  def region_names_and_slugs do
    query =
      from r in Region,
        order_by: :name,
        select: {r.name, r.slug}

    Repo.all(query)
  end

  @doc """
  Creates a region.

  ## Examples

      iex> create_region(%{field: value})
      {:ok, %Region{}}

      iex> create_region(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_region(attrs \\ %{}) do
    %Region{}
    |> Region.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a region.

  ## Examples

      iex> update_region(region, %{field: new_value})
      {:ok, %Region{}}

      iex> update_region(region, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_region(%Region{} = region, attrs) do
    region
    |> Region.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a region.

  ## Examples

      iex> delete_region(region)
      {:ok, %Region{}}

      iex> delete_region(region)
      {:error, %Ecto.Changeset{}}

  """
  def delete_region(%Region{} = region) do
    Repo.delete(region)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking region changes.

  ## Examples

      iex> change_region(region)
      %Ecto.Changeset{data: %Region{}}

  """
  def change_region(%Region{} = region, attrs \\ %{}) do
    Region.changeset(region, attrs)
  end
end
