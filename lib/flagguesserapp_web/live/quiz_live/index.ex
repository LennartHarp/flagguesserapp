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
          <div :for={choice <- shuffle_choices(@flags, @current_flag)}>
            <button phx-click="check_answer" phx-value-choice={choice}>
              {choice}
            </button>
          </div>
          
          <button id="next_button" phx-click={JS.toggle(to: "#next_button")} class="hidden">
            Next
          </button>
        </div>
      </:content>
      
      <:result>
        You've got: {@score_index}/{Enum.count(@flags)}!
      </:result>
      
      <:actions>
        <div class="quizcard-action">
          <button phx-click="next_flag">
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
    flags = region.flags

    socket =
      socket
      |> assign(:page_title, region.name)
      |> assign(:region, region)
      |> assign(:flags, flags)
      |> assign(:current_index, 0)
      |> assign(:score_index, 0)
      |> assign(:current_flag, Enum.at(flags, 0))

    {:noreply, socket}
  end

  def shuffle_choices(flags, current_flag) do
    correct_name = current_flag.name
    other_names = Enum.map(flags -- [current_flag], & &1.name)

    [correct_name | Enum.take_random(other_names, 3)]
    |> Enum.shuffle()
  end

  def handle_event("check_answer", %{"choice" => choice}, socket)
      when choice == socket.assigns.current_flag.name do
    socket =
      socket
      |> update(:score_index, &(&1 + 1))
      |> load_next_flag()

    {:noreply, socket}
  end

  def handle_event("check_answer", _params, socket) do
    socket =
      socket
      |> load_next_flag()

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

  defp load_next_flag(socket) do
    socket
    |> update(:current_index, &(&1 + 1))
    |> assign(
      :current_flag,
      Enum.at(socket.assigns[:flags], socket.assigns[:current_index] + 1)
    )
  end
end
