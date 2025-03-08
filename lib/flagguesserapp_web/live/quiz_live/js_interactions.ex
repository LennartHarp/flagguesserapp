defmodule FlagguesserappWeb.QuizLive.JSInteractions do
  alias Phoenix.LiveView.JS
  alias Flagguesserapp.Flags.Flag

  def show_answer(is_correct, dom_id) do
    JS.push("check_answer")
    |> JS.show(
      to: "#quiz-next_button",
      transition: {"ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> JS.toggle_class(toggle_button_color(is_correct), to: "##{dom_id}")
    |> JS.set_attribute({"disabled", "true"}, to: "[id^='quiz-choice-button-']")
  end

  def hide_answer() do
    JS.push("next")
    |> JS.hide(
      to: "#quiz-next_button",
      transition: {"ease-out duration-300", "opacity-100", "opacity-0"}
    )
    |> JS.remove_class("!bg-green-500 !bg-red-500", to: "[id^='quiz-choice-button-']")
    |> JS.remove_attribute("disabled", to: "[id^='quiz-choice-button-']")
  end

  def show_results() do
    JS.show(
      to: "#results",
      transition: {"ease-out duration-1000", "opacity-0", "opacity-100"}
    )
  end

  defp toggle_button_color(true) do
    "!bg-green-500"
  end

  defp toggle_button_color(false) do
    "!bg-red-500"
  end

  def toggle_result_color(true) do
    "border-4 border-green-600 rounded-xl"
  end

  def toggle_result_color(false) do
    "border-4 border-red-600 rounded-xl"
  end

  def toggle_retry(nil) do
    ""
  end

  def toggle_retry(%Flag{}) do
    "Do you really want to retry?"
  end
end
