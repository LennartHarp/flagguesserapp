defmodule Flagguesserapp.Flags do
  @moduledoc """
  The Flags context.
  """

  import Ecto.Query, warn: false
  alias Flagguesserapp.Repo

  alias Flagguesserapp.Flags.Flag

  @doc """
  Returns the list of flags.

  ## Examples

      iex> list_flags()
      [%Flag{}, ...]

  """

  def subscribe(flagd_id) do
    Phoenix.PubSub.subscribe(Flagguesserapp.PubSub, "flag:#{flagd_id}")
  end

  def broadcast(flagd_id, message) do
    Phoenix.PubSub.broadcast(Flagguesserapp.PubSub, "flag:#{flagd_id}", message)
  end

  def list_flags do
    Repo.all(Flag)
  end

  def list_flags_with_regions do
    Repo.all(Flag) |> Repo.preload(:region)
  end

  def random_flag do
    Flag
    |> Repo.all()
    |> Enum.random()
  end

  def filter_flags(filter, limit \\ nil) do
    Flag
    |> search_by(filter["q"])
    |> with_region(filter["region"])
    |> sort(filter["sort_by"])
    |> limit_query(limit)
    |> Repo.all()
    |> Repo.preload(:region)
  end

  defp with_region(query, slug) when slug in ["", nil], do: query

  defp with_region(query, slug) do
    from f in query,
      join: r in assoc(f, :region),
      on: f.region_id == r.id,
      where: r.slug == ^slug
  end

  defp search_by(query, q) when q in ["", nil], do: query

  defp search_by(query, q) do
    where(query, [f], ilike(f.name, ^"%#{q}%"))
  end

  defp sort(query, "name_desc") do
    order_by(query, desc: :name)
  end

  defp sort(query, "name_asc") do
    order_by(query, asc: :name)
  end

  defp sort(query, "region") do
    from f in query,
      join: r in assoc(f, :region),
      order_by: r.name
  end

  defp sort(query, _) do
    order_by(query, :id)
  end

  defp limit_query(query, nil), do: query

  defp limit_query(query, limit), do: query |> limit(^limit)

  @doc """
  Gets a single flag.

  Raises `Ecto.NoResultsError` if the Flag does not exist.

  ## Examples

      iex> get_flag!(123)
      %Flag{}

      iex> get_flag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flag!(id), do: Repo.get!(Flag, id)

  def get_flag_with_region!(id) do
    get_flag!(id) |> Repo.preload(:region)
  end

  @doc """
  Creates a flag.

  ## Examples

      iex> create_flag(%{field: value})
      {:ok, %Flag{}}

      iex> create_flag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flag(attrs \\ %{}) do
    %Flag{}
    |> Flag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flag.

  ## Examples

      iex> update_flag(flag, %{field: new_value})
      {:ok, %Flag{}}

      iex> update_flag(flag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flag(%Flag{} = flag, attrs) do
    flag
    |> Flag.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, flag} ->
        flag = Repo.preload(flag, :region)
        broadcast(flag.id, %{updated_flag: flag})
        {:ok, flag}

      {:error, flag} ->
        {:error, flag}
    end
  end

  @doc """
  Deletes a flag.

  ## Examples

      iex> delete_flag(flag)
      {:ok, %Flag{}}

      iex> delete_flag(flag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flag(%Flag{} = flag) do
    Repo.delete(flag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flag changes.

  ## Examples

      iex> change_flag(flag)
      %Ecto.Changeset{data: %Flag{}}

  """
  def change_flag(%Flag{} = flag, attrs \\ %{}) do
    Flag.changeset(flag, attrs)
  end
end
