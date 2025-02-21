defmodule Flagguesserapp.RegionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Flagguesserapp.Regions` context.
  """

  @doc """
  Generate a unique region name.
  """
  def unique_region_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique region slug.
  """
  def unique_region_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a region.
  """
  def region_fixture(attrs \\ %{}) do
    {:ok, region} =
      attrs
      |> Enum.into(%{
        image_path: "some image_path",
        name: unique_region_name(),
        slug: unique_region_slug()
      })
      |> Flagguesserapp.Regions.create_region()

    region
  end
end
