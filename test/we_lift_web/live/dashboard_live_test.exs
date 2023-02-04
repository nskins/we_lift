defmodule WeLiftWeb.DashboardLiveTest do
  use WeLiftWeb.ConnCase

  import Phoenix.LiveViewTest

  defp log_in(params) do
    register_and_log_in_user(params)
  end

  describe "Index" do
    setup [:log_in]

    test "redirects to workout list", %{conn: conn} do
      {:ok, index_live, _} = live(conn, ~p"/dashboard")

      {:ok, _, html} =
        index_live
        |> element("a", "Workouts")
        |> render_click()
        |> follow_redirect(conn)

      assert html =~ "Start New Workout"
    end

    test "redirects to exercise history page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/dashboard")

      {:ok, _, html} =
        index_live
        |> element("a", "Exercise History")
        |> render_click()
        |> follow_redirect(conn)

      assert html =~ "Exercise History"
    end
  end
end
