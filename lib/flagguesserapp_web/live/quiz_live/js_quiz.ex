defmodule FlagguesserappWeb.QuizLive.JSQuiz do
  alias Phoenix.LiveView.JS
  alias Flagguesserapp.Flags.Flag

  def show_answer(event \\ %JS{}, is_correct, dom_id) do
    event
    |> JS.show(
      to: "#quiz-next-button",
      transition: {"ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> JS.toggle_class(toggle_button_color(is_correct), to: "##{dom_id}")
    |> JS.set_attribute({"disabled", "true"}, to: "[id^='quiz-choice-button-']")
    |> enable_actions()
  end

  def hide_answer(event \\ %JS{}) do
    event
    |> JS.hide(
      to: "#quiz-next-button",
      transition: {"ease-out duration-300", "opacity-100", "opacity-0"}
    )
    |> JS.remove_class("!bg-green-500 !bg-red-500", to: "[id^='quiz-choice-button-']")
    |> JS.remove_attribute("disabled", to: "[id^='quiz-choice-button-']")
    |> disable_actions()
  end

  def enable_actions(event \\ %JS{}) do
    event
    |> JS.remove_attribute("disabled", to: "#quiz-skip-button")
    |> JS.remove_attribute("disabled", to: "#quiz-retry-button")
  end

  def disable_actions(event \\ %JS{}) do
    event
    |> JS.remove_attribute("disabled", to: "#quiz-skip-button")
    |> JS.remove_attribute("disabled", to: "#quiz-retry-button")
  end

  def show_results(event \\ %JS{}) do
    event
    |> JS.show(
      to: "#results",
      transition: {"ease-out duration-1000", "opacity-0", "opacity-100"}
    )
  end

  def hide_results(event \\ %JS{}) do
    event
    |> JS.hide(
      to: "#results",
      transition: {"ease-out duration-1000", "opacity-100", "opacity-0"}
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
