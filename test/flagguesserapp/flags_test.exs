defmodule Flagguesserapp.FlagsTest do
  use Flagguesserapp.DataCase

  alias Flagguesserapp.Flags

  describe "flags" do
    alias Flagguesserapp.Flags.Flag

    import Flagguesserapp.FlagsFixtures

    @invalid_attrs %{name: nil, image_path: nil}

    test "list_flags/0 returns all flags" do
      flag = flag_fixture()
      assert Flags.list_flags() == [flag]
    end

    test "get_flag!/1 returns the flag with given id" do
      flag = flag_fixture()
      assert Flags.get_flag!(flag.id) == flag
    end

    test "create_flag/1 with valid data creates a flag" do
      valid_attrs = %{name: "some name", image_path: "some image_path"}

      assert {:ok, %Flag{} = flag} = Flags.create_flag(valid_attrs)
      assert flag.name == "some name"
      assert flag.image_path == "some image_path"
    end

    test "create_flag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flags.create_flag(@invalid_attrs)
    end

    test "update_flag/2 with valid data updates the flag" do
      flag = flag_fixture()
      update_attrs = %{name: "some updated name", image_path: "some updated image_path"}

      assert {:ok, %Flag{} = flag} = Flags.update_flag(flag, update_attrs)
      assert flag.name == "some updated name"
      assert flag.image_path == "some updated image_path"
    end

    test "update_flag/2 with invalid data returns error changeset" do
      flag = flag_fixture()
      assert {:error, %Ecto.Changeset{}} = Flags.update_flag(flag, @invalid_attrs)
      assert flag == Flags.get_flag!(flag.id)
    end

    test "delete_flag/1 deletes the flag" do
      flag = flag_fixture()
      assert {:ok, %Flag{}} = Flags.delete_flag(flag)
      assert_raise Ecto.NoResultsError, fn -> Flags.get_flag!(flag.id) end
    end

    test "change_flag/1 returns a flag changeset" do
      flag = flag_fixture()
      assert %Ecto.Changeset{} = Flags.change_flag(flag)
    end
  end

  describe "flags" do
    alias Flagguesserapp.Flags.Flag

    import Flagguesserapp.FlagsFixtures

    @invalid_attrs %{name: nil, image_path: nil}

    test "list_flags/0 returns all flags" do
      flag = flag_fixture()
      assert Flags.list_flags() == [flag]
    end

    test "get_flag!/1 returns the flag with given id" do
      flag = flag_fixture()
      assert Flags.get_flag!(flag.id) == flag
    end

    test "create_flag/1 with valid data creates a flag" do
      valid_attrs = %{name: "some name", image_path: "some image_path"}

      assert {:ok, %Flag{} = flag} = Flags.create_flag(valid_attrs)
      assert flag.name == "some name"
      assert flag.image_path == "some image_path"
    end

    test "create_flag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flags.create_flag(@invalid_attrs)
    end

    test "update_flag/2 with valid data updates the flag" do
      flag = flag_fixture()
      update_attrs = %{name: "some updated name", image_path: "some updated image_path"}

      assert {:ok, %Flag{} = flag} = Flags.update_flag(flag, update_attrs)
      assert flag.name == "some updated name"
      assert flag.image_path == "some updated image_path"
    end

    test "update_flag/2 with invalid data returns error changeset" do
      flag = flag_fixture()
      assert {:error, %Ecto.Changeset{}} = Flags.update_flag(flag, @invalid_attrs)
      assert flag == Flags.get_flag!(flag.id)
    end

    test "delete_flag/1 deletes the flag" do
      flag = flag_fixture()
      assert {:ok, %Flag{}} = Flags.delete_flag(flag)
      assert_raise Ecto.NoResultsError, fn -> Flags.get_flag!(flag.id) end
    end

    test "change_flag/1 returns a flag changeset" do
      flag = flag_fixture()
      assert %Ecto.Changeset{} = Flags.change_flag(flag)
    end
  end

  describe "flags" do
    alias Flagguesserapp.Flags.Flag

    import Flagguesserapp.FlagsFixtures

    @invalid_attrs %{name: nil, image_path: nil}

    test "list_flags/0 returns all flags" do
      flag = flag_fixture()
      assert Flags.list_flags() == [flag]
    end

    test "get_flag!/1 returns the flag with given id" do
      flag = flag_fixture()
      assert Flags.get_flag!(flag.id) == flag
    end

    test "create_flag/1 with valid data creates a flag" do
      valid_attrs = %{name: "some name", image_path: "some image_path"}

      assert {:ok, %Flag{} = flag} = Flags.create_flag(valid_attrs)
      assert flag.name == "some name"
      assert flag.image_path == "some image_path"
    end

    test "create_flag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flags.create_flag(@invalid_attrs)
    end

    test "update_flag/2 with valid data updates the flag" do
      flag = flag_fixture()
      update_attrs = %{name: "some updated name", image_path: "some updated image_path"}

      assert {:ok, %Flag{} = flag} = Flags.update_flag(flag, update_attrs)
      assert flag.name == "some updated name"
      assert flag.image_path == "some updated image_path"
    end

    test "update_flag/2 with invalid data returns error changeset" do
      flag = flag_fixture()
      assert {:error, %Ecto.Changeset{}} = Flags.update_flag(flag, @invalid_attrs)
      assert flag == Flags.get_flag!(flag.id)
    end

    test "delete_flag/1 deletes the flag" do
      flag = flag_fixture()
      assert {:ok, %Flag{}} = Flags.delete_flag(flag)
      assert_raise Ecto.NoResultsError, fn -> Flags.get_flag!(flag.id) end
    end

    test "change_flag/1 returns a flag changeset" do
      flag = flag_fixture()
      assert %Ecto.Changeset{} = Flags.change_flag(flag)
    end
  end

  describe "flags" do
    alias Flagguesserapp.Flags.Flag

    import Flagguesserapp.FlagsFixtures

    @invalid_attrs %{name: nil, continent: nil, image_path: nil}

    test "list_flags/0 returns all flags" do
      flag = flag_fixture()
      assert Flags.list_flags() == [flag]
    end

    test "get_flag!/1 returns the flag with given id" do
      flag = flag_fixture()
      assert Flags.get_flag!(flag.id) == flag
    end

    test "create_flag/1 with valid data creates a flag" do
      valid_attrs = %{name: "some name", continent: "some continent", image_path: "some image_path"}

      assert {:ok, %Flag{} = flag} = Flags.create_flag(valid_attrs)
      assert flag.name == "some name"
      assert flag.continent == "some continent"
      assert flag.image_path == "some image_path"
    end

    test "create_flag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flags.create_flag(@invalid_attrs)
    end

    test "update_flag/2 with valid data updates the flag" do
      flag = flag_fixture()
      update_attrs = %{name: "some updated name", continent: "some updated continent", image_path: "some updated image_path"}

      assert {:ok, %Flag{} = flag} = Flags.update_flag(flag, update_attrs)
      assert flag.name == "some updated name"
      assert flag.continent == "some updated continent"
      assert flag.image_path == "some updated image_path"
    end

    test "update_flag/2 with invalid data returns error changeset" do
      flag = flag_fixture()
      assert {:error, %Ecto.Changeset{}} = Flags.update_flag(flag, @invalid_attrs)
      assert flag == Flags.get_flag!(flag.id)
    end

    test "delete_flag/1 deletes the flag" do
      flag = flag_fixture()
      assert {:ok, %Flag{}} = Flags.delete_flag(flag)
      assert_raise Ecto.NoResultsError, fn -> Flags.get_flag!(flag.id) end
    end

    test "change_flag/1 returns a flag changeset" do
      flag = flag_fixture()
      assert %Ecto.Changeset{} = Flags.change_flag(flag)
    end
  end
end
