defmodule FlagguesserappWeb.QuizLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  import FlagguesserappWeb.CustomComponents

  def render(assigns) do
    ~H"""
    <.background image_path="/images/flags_background.jpg" />
    <.quiz_card flag={@current_flag}>
      <:content>
        <div class="quizcard-button">
          <div :for={
            {flag, index} <-
              Enum.with_index(
                [@current_flag | Enum.take_random(@flags -- [@current_flag], 3)]
                |> Enum.shuffle()
              )
          }>
            <button
              id={"choice-button-#{index}"}
              phx-click={show_answer(@current_flag == flag, "choice-button-#{index}")}
              phx-value-name={flag.name}
              class="transition-colors duration-300"
            >
              {flag.name}
            </button>
          </div>
          
          <button id="next_button" phx-click={hide_answer()} class="hidden">
            Next
          </button>
        </div>
      </:content>
      
      <:result>
        You've got: {@score_index}/{Enum.count(@flags)}!
        <button phx-click="retry">
          Retry <.icon name="hero-arrow-left-circle" />
        </button>
      </:result>
      
      <:actions>
        <div class="quizcard-action-right">
          <button phx-click={hide_answer()}>
            Skip <.icon name="hero-arrow-right-circle" />
          </button>
        </div>
      </:actions>
    </.quiz_card>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _uri, socket) do
    region = Regions.get_region_with_flags!(slug)
    flags = region.flags |> Enum.shuffle()

    socket =
      socket
      |> assign(:page_title, region.name)
      |> assign(:region, region)
      |> assign(:flags, flags)
      # Next Flag per next_index?
      |> assign(:current_index, 0)
      |> assign(:score_index, 0)
      |> assign(:current_flag, Enum.at(flags, 0))

    {:noreply, socket}
  end

  def handle_event("check_answer", %{"name" => name}, socket)
      when name == socket.assigns.current_flag.name do
    socket =
      socket
      |> update(:score_index, &(&1 + 1))

    {:noreply, socket}
  end

  def handle_event("check_answer", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("next_flag", _params, %{assigns: %{current_flag: flag}} = socket)
      when flag in [nil, ""] do
    {:noreply, push_navigate(socket, to: ~p"/flags/overview")}
  end

  def handle_event("next_flag", _params, socket) do
    socket = load_next_flag(socket)

    {:noreply, socket}
  end

  def handle_event("retry", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/quiz/#{socket.assigns[:region].slug}")}
  end

  defp load_next_flag(socket) do
    socket
    |> update(:current_index, &(&1 + 1))
    |> assign(
      :current_flag,
      Enum.at(socket.assigns[:flags], socket.assigns[:current_index] + 1)
    )
  end

  defp show_answer(is_correct, dom_id) do
    JS.push("check_answer")
    |> JS.show(
      to: "#next_button",
      transition: {"ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> JS.toggle_class(toggle_button_color(is_correct), to: "##{dom_id}")
    |> JS.toggle_attribute({"disabled", "true"}, to: "[id^='choice-button-']")
  end

  defp hide_answer() do
    JS.push("next_flag")
    |> JS.hide(
      to: "#next_button",
      transition: {"ease-out duration-300", "opacity-100", "opacity-0"}
    )
    |> JS.remove_class("!bg-green-500 !bg-red-500", to: "[id^='choice-button-']")
    |> JS.toggle_attribute({"disabled", nil}, to: "[id^='choice-button-']")
  end

  defp toggle_button_color(true) do
    "!bg-green-500"
  end

  defp toggle_button_color(false) do
    "!bg-red-500"
  end
end
