defmodule WeLiftWeb.WorkoutLive.EditTest do
  use WeLiftWeb.ConnCase

  import Phoenix.LiveViewTest
  import WeLift.WorkoutsFixtures

  defp create_workout(params) do
    logged_in_params = register_and_log_in_user(params)

    workout = workout_fixture(%{"user" => logged_in_params.user})

    logged_in_params
    |> Enum.into(%{workout: workout})
  end

  describe "Edit Workout" do
    setup [:create_workout]

    test "should allow the user to create a set after creating a custom exercise", %{
      conn: conn,
      workout: workout
    } do
      {:ok, index_live, _html} = live(conn, ~p"/workouts/#{workout.id}/edit")

      # Choose a different default exercise. There was some strange behavior
      # during development if I did this before creating a custom exercise.
      # However, that bug should be fixed, and this test helps to verify that.
      assert index_live
             |> element("#submit_set_form")
             |> render_change(set: %{exercise_id: 4}) =~ "\" value=\"4\""

      # Open the custom exercise dialog.
      index_live
      |> element("#add_custom_exercise_link")
      |> render_click()

      # Submit the custom exercise form.
      index_live
      |> element("#submit_exercise_form")
      |> render_submit(exercise: %{name: "Power Clean"})

      # Update the set form with weight and reps.
      index_live
      |> element("#submit_set_form")
      |> render_change(set: %{weight_in_lbs: 135, reps: 4})

      # A set should appear on the page after we submit the form.
      assert index_live
             |> element("#submit_set_form")
             |> render_submit() =~ "<div class=\"font-bold w-32\">Power Clean</div>"
    end
  end
end
