defmodule FlagguesserappWeb.FlagLiveTest do
  use FlagguesserappWeb.ConnCase

  import Phoenix.LiveViewTest
  import Flagguesserapp.FlagsFixtures

  @create_attrs %{name: "some name", continent: "some continent", image_path: "some image_path"}
  @update_attrs %{name: "some updated name", continent: "some updated continent", image_path: "some updated image_path"}
  @invalid_attrs %{name: nil, continent: nil, image_path: nil}

  defp create_flag(_) do
    flag = flag_fixture()
    %{flag: flag}
  end

  describe "Index" do
    setup [:create_flag]

    test "lists all flags", %{conn: conn, flag: flag} do
      {:ok, _index_live, html} = live(conn, ~p"/flags")

      assert html =~ "Listing Flags"
      assert html =~ flag.name
    end

    test "saves new flag", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/flags")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Flag")
               |> render_click()
               |> follow_redirect(conn, ~p"/flags/new")

      assert render(form_live) =~ "New Flag"

      assert form_live
             |> form("#flag-form", flag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#flag-form", flag: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/flags")

      html = render(index_live)
      assert html =~ "Flag created successfully"
      assert html =~ "some name"
    end

    test "updates flag in listing", %{conn: conn, flag: flag} do
      {:ok, index_live, _html} = live(conn, ~p"/flags")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#flags-#{flag.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/flags/#{flag}/edit")

      assert render(form_live) =~ "Edit Flag"

      assert form_live
             |> form("#flag-form", flag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#flag-form", flag: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/flags")

      html = render(index_live)
      assert html =~ "Flag updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes flag in listing", %{conn: conn, flag: flag} do
      {:ok, index_live, _html} = live(conn, ~p"/flags")

      assert index_live |> element("#flags-#{flag.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#flags-#{flag.id}")
    end
  end

  describe "Show" do
    setup [:create_flag]

    test "displays flag", %{conn: conn, flag: flag} do
      {:ok, _show_live, html} = live(conn, ~p"/flags/#{flag}")

      assert html =~ "Show Flag"
      assert html =~ flag.name
    end

    test "updates flag and returns to show", %{conn: conn, flag: flag} do
      {:ok, show_live, _html} = live(conn, ~p"/flags/#{flag}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/flags/#{flag}/edit?return_to=show")

      assert render(form_live) =~ "Edit Flag"

      assert form_live
             |> form("#flag-form", flag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#flag-form", flag: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/flags/#{flag}")

      html = render(show_live)
      assert html =~ "Flag updated successfully"
      assert html =~ "some updated name"
    end
  end
end
