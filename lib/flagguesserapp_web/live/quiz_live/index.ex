defmodule FlagguesserappWeb.QuizLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  alias FlagguesserappWeb.QuizLive.JSQuiz

  import FlagguesserappWeb.CustomComponents

  def render(assigns) do
    ~H"""
    <.quizcard>
      <:content>
        <%= if @current_flag do %>
          <div class="quizcard-image-container">
            <img src={@current_flag.image_path} alt="Flag" />
          </div>
          
          <div class="quizcard-button">
            <%= for {flag, index} <- quiz_choices(@current_flag, @region.flags) do %>
              <button
                id={"quiz-choice-button-#{index}"}
                phx-click={
                  JS.push("validate")
                  |> JSQuiz.show_answer(@current_flag == flag, "quiz-choice-button-#{index}")
                }
                phx-value-name={flag.name}
                class="transition-colors duration-300"
              >
                {flag.name}
              </button>
            <% end %>
            
            <button
              id="quiz-next-button"
              phx-click={
                JS.push("next", loading: ["#quizcard", "#quiz-spinner"])
                |> JSQuiz.hide_answer()
              }
              class="hidden"
            >
              Next
            </button>
          </div>
        <% else %>
          <div class="quizcard-score">
            You've got: {Enum.count(@region.flags, &(&1 in @score))} / {Enum.count(@region.flags)}!
            <button phx-click={JSQuiz.show_results()}>
              <h4>Show Answers <.icon name="hero-chevron-double-down" /></h4>
            </button>
          </div>
        <% end %>
      </:content>
      
      <:actions>
        <button
          id="quiz-retry-button"
          phx-click={JS.push("retry") |> JSQuiz.hide_results()}
          data-confirm={JSQuiz.toggle_retry(@current_flag)}
        >
          <.icon name="hero-arrow-path" />
        </button>
        
        <%= if @current_flag do %>
          <h1>
            {Enum.find_index(@region.flags, &(&1 == @current_flag)) + 1} / {Enum.count(@region.flags)}
          </h1>
          
          <button
            id="quiz-skip-button"
            phx-click={
              JS.push("next", loading: ["#quizcard", "#quiz-spinner"])
              |> JSQuiz.hide_answer()
            }
          >
            <.icon name="hero-arrow-right-circle" />
          </button>
        <% else %>
          <button phx-click={JS.push("end") |> JSQuiz.hide_answer()}>
            <.icon name="hero-arrow-right-circle" />
          </button>
        <% end %>
      </:actions>
    </.quizcard>

    <div id="results" class="hidden mt-12">
      <div class="flagcard-grid">
        <.flag_simple_card
          :for={flag <- @region.flags}
          flag={flag}
          class={JSQuiz.toggle_result_color(flag in @score)}
        />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_new(:score, fn -> [] end)

    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _uri, socket) do
    region =
      slug
      |> Regions.get_region_with_flags!()
      |> Map.update!(:flags, &Enum.shuffle(&1))

    socket =
      socket
      |> assign(page_title: region.name)
      |> assign(region: region)
      |> assign(current_flag: Enum.at(region.flags, 0))

    {:noreply, socket}
  end

  def handle_event("validate", %{"name" => name}, %{assigns: %{current_flag: flag}} = socket) do
    if name == flag.name do
      {:noreply, update(socket, :score, &[flag | &1])}
    else
      {:noreply, socket}
    end
  end

  def handle_event("next", _params, %{assigns: %{current_flag: flag, region: region}} = socket) do
    new_index = Enum.find_index(region.flags, &(&1 == flag)) + 1

    socket =
      socket
      |> assign(:current_flag, Enum.at(region.flags, new_index))

    {:noreply, push_event(socket, "enable_actions", %{})}
  end

  def handle_event("retry", _params, socket) do
    {:noreply, push_patch(socket, to: ~p"/quiz/#{socket.assigns.region.slug}")}
  end

  def handle_event("end", _params, socket) do
    {:noreply, redirect(socket, to: ~p"/")}
  end

  defp quiz_choices(current_flag, flags) do
    [current_flag | Enum.take_random(flags -- [current_flag], 3)]
    |> Enum.shuffle()
    |> Enum.with_index()
  end
end
