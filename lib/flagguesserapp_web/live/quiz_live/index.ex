defmodule FlagguesserappWeb.QuizLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  import FlagguesserappWeb.CustomComponents

  def render(assigns) do
    ~H"""
    <div>
      <.quiz_card flag={@current_flag} choices={["1", "2", "3", "4"]} />
      <button phx-click="next_flag">Weiter</button>
    </div>
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
      |> assign(:current_flag, Enum.at(flags, 0))

    {:noreply, socket}
  end

  def handle_event("next_flag", _params, socket)
      when is_map_key(socket.assigns, :current_flag) and
             socket.assigns.current_flag in [nil, ""] do
    {:noreply, push_navigate(socket, to: ~p"/flags/overview")}
  end

  def handle_event("next_flag", _params, socket) do
    current_index = socket.assigns[:current_index]
    flags = socket.assigns[:flags]

    next_index = current_index + 1

    new_flag = if next_index < length(flags), do: Enum.at(flags, next_index), else: nil

    socket =
      socket
      |> assign(:current_index, next_index)
      |> assign(:current_flag, new_flag)

    {:noreply, socket}
  end
end
