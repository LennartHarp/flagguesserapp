defmodule FlagguesserappWeb.FlagLive.Show do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      <h1 class="text-xl font-semibold mb-4">This is a {@flag.name}'s flag!</h1>
       <img src={@flag.image_path} class="rounded-lg shadow-lg border-2 border-gray-300" />
      <:actions>
        <.button phx-click={JS.dispatch("click", to: {:inner, "a"})}>
          <.link navigate={~p"/flags/#{@flag}/edit?return_to=show"}>
            Edit flag
          </.link>
        </.button>
      </:actions>
    </.header>

    <.list>
      <:item title="Name">{@flag.name}</:item>
      
      <:item title="Continent">{@flag.continent}</:item>
      
      <:item title="Image path">{@flag.image_path}</:item>
    </.list>

    <.back navigate={~p"/flags"}>Back to flags</.back>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Flag")
     |> assign(:flag, Flags.get_flag!(id))}
  end
end
