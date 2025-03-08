defmodule FlagguesserappWeb.QuizLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  alias FlagguesserappWeb.QuizLive.JSInteractions

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
                [@current_flag | Enum.take_random(@region.flags -- [@current_flag], 3)]
                |> Enum.shuffle()
              )
          }>
            <button
              id={"quiz-choice-button-#{index}"}
              phx-click={
                JSInteractions.show_answer(@current_flag == flag, "quiz-choice-button-#{index}")
              }
              phx-value-name={flag.name}
              class="transition-colors duration-300"
            >
              {flag.name}
            </button>
          </div>
          
          <button id="quiz-next_button" phx-click={JSInteractions.hide_answer()} class="hidden">
            Next
          </button>
        </div>
      </:content>
      
      <:result>
        You've got: {@score_index}/{Enum.count(@region.flags)}!
        <button phx-click={JSInteractions.show_results()}>
          <h4>Show Answers <.icon name="hero-chevron-double-down" /></h4>
        </button>
      </:result>
      
      <:actions>
        <div class="quizcard-action">
          <button
            id="quiz-retry-button"
            phx-click="retry"
            data-confirm={JSInteractions.toggle_retry(@current_flag)}
          >
            <.icon name="hero-arrow-path" />
          </button>
          
          <h1>{@score_index}/{Enum.count(@region.flags)}</h1>
          
          <button phx-click={JSInteractions.hide_answer()}>
            <.icon name="hero-arrow-right-circle" />
          </button>
        </div>
      </:actions>
    </.quiz_card>

    <div id="results" class="hidden mt-12">
      <div class="flagcard-grid">
        <.flag_simple_card
          :for={flag <- @region.flags}
          flag={flag}
          class={JSInteractions.toggle_result_color(flag in @score)}
        />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _uri, socket) do
    region =
      slug
      |> Regions.get_region_with_flags!()
      |> Map.update!(:flags, &Enum.shuffle(&1))

    socket =
      socket
      |> assign(:page_title, region.name)
      |> assign(:region, region)
      |> assign(:current_index, 0)
      |> assign(:score_index, 0)
      |> assign(:score, [])
      |> assign(:current_flag, Enum.at(region.flags, 0))

    {:noreply, socket}
  end

  def handle_event("check_answer", %{"name" => name}, socket)
      when name == socket.assigns.current_flag.name do
    socket =
      socket
      |> update(:score_index, &(&1 + 1))
      |> update(:score, &[socket.assigns.current_flag | &1])

    {:noreply, socket}
  end

  def handle_event("check_answer", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("next", _params, %{assigns: %{current_flag: flag}} = socket)
      when flag in [nil, ""] do
    {:noreply, push_navigate(socket, to: ~p"/flags/overview")}
  end

  def handle_event("next", _params, socket) do
    {:noreply, load_next(socket)}
  end

  def handle_event("retry", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/quiz/#{socket.assigns[:region].slug}")}
  end

  defp load_next(socket) do
    socket
    |> update(:current_index, &(&1 + 1))
    |> assign(
      :current_flag,
      Enum.at(socket.assigns[:region].flags, socket.assigns[:current_index] + 1)
    )
  end
end
