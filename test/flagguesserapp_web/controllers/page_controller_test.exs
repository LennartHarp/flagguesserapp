defmodule FlagguesserappWeb.PageControllerTest do
  use FlagguesserappWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/select/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end
end
