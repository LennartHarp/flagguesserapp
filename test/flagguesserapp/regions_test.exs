defmodule Flagguesserapp.RegionsTest do
  use Flagguesserapp.DataCase

  alias Flagguesserapp.Regions

  describe "regions" do
    alias Flagguesserapp.Regions.Region

    import Flagguesserapp.RegionsFixtures

    @invalid_attrs %{name: nil, slug: nil, image_path: nil}

    test "list_regions/0 returns all regions" do
      region = region_fixture()
      assert Regions.list_regions() == [region]
    end

    test "get_region!/1 returns the region with given id" do
      region = region_fixture()
      assert Regions.get_region!(region.id) == region
    end

    test "create_region/1 with valid data creates a region" do
      valid_attrs = %{name: "some name", slug: "some slug", image_path: "some image_path"}

      assert {:ok, %Region{} = region} = Regions.create_region(valid_attrs)
      assert region.name == "some name"
      assert region.slug == "some slug"
      assert region.image_path == "some image_path"
    end

    test "create_region/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Regions.create_region(@invalid_attrs)
    end

    test "update_region/2 with valid data updates the region" do
      region = region_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug", image_path: "some updated image_path"}

      assert {:ok, %Region{} = region} = Regions.update_region(region, update_attrs)
      assert region.name == "some updated name"
      assert region.slug == "some updated slug"
      assert region.image_path == "some updated image_path"
    end

    test "update_region/2 with invalid data returns error changeset" do
      region = region_fixture()
      assert {:error, %Ecto.Changeset{}} = Regions.update_region(region, @invalid_attrs)
      assert region == Regions.get_region!(region.id)
    end

    test "delete_region/1 deletes the region" do
      region = region_fixture()
      assert {:ok, %Region{}} = Regions.delete_region(region)
      assert_raise Ecto.NoResultsError, fn -> Regions.get_region!(region.id) end
    end

    test "change_region/1 returns a region changeset" do
      region = region_fixture()
      assert %Ecto.Changeset{} = Regions.change_region(region)
    end
  end
end
