defmodule Flagguesserapp.FlagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Flagguesserapp.Flags` context.
  """

  @doc """
  Generate a unique flag continent.
  """
  def unique_flag_continent, do: "some continent#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique flag image_path.
  """
  def unique_flag_image_path, do: "some image_path#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique flag name.
  """
  def unique_flag_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a flag.
  """
  def flag_fixture(attrs \\ %{}) do
    {:ok, flag} =
      attrs
      |> Enum.into(%{
        continent: unique_flag_continent(),
        image_path: unique_flag_image_path(),
        name: unique_flag_name()
      })
      |> Flagguesserapp.Flags.create_flag()

    flag
  end
end
