defmodule Flagguesserapp.Modes do
  @moduledoc """
  The modes context.
  """

  import Ecto.Query, warn: false
  alias Flagguesserapp.Repo

  alias Flagguesserapp.Modes.Mode

  @doc """
  Returns the list of modes.

  ## Examples

      iex> list_modes()
      [%mode{}, ...]

  """
  def list_modes do
    Repo.all(Mode)
  end

  def random_mode do
    Mode
    |> Repo.all()
    |> Enum.random()
  end

  @doc """
  Gets a single mode.

  Raises `Ecto.NoResultsError` if the mode does not exist.

  ## Examples

      iex> get_mode!(123)
      %mode{}

      iex> get_mode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mode!(id), do: Repo.get!(Mode, id)

  @doc """
  Creates a mode.

  ## Examples

      iex> create_mode(%{field: value})
      {:ok, %mode{}}

      iex> create_mode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mode(attrs \\ %{}) do
    %Mode{}
    |> Mode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mode.

  ## Examples

      iex> update_mode(mode, %{field: new_value})
      {:ok, %mode{}}

      iex> update_mode(mode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mode(%Mode{} = mode, attrs) do
    mode
    |> Mode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mode.

  ## Examples

      iex> delete_mode(mode)
      {:ok, %mode{}}

      iex> delete_mode(mode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mode(%Mode{} = mode) do
    Repo.delete(mode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mode changes.

  ## Examples

      iex> change_mode(mode)
      %Ecto.Changeset{data: %mode{}}

  """
  def change_mode(%Mode{} = mode, attrs \\ %{}) do
    Mode.changeset(mode, attrs)
  end
end
