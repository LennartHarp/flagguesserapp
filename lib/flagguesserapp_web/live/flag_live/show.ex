defmodule FlagguesserappWeb.FlagLive.Show do
  use FlagguesserappWeb, :live_view

  import FlagguesserappWeb.CustomComponents

  alias Flagguesserapp.Flags

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header class="flex items-center justify-center mb-8">
        <h1 class="text-xl font-semibold">This is {@flag.name}'s flag!</h1>
        
        <:actions>
          <.button phx-click={JS.dispatch("click", to: {:inner, "a"})}>
            <.link navigate={~p"/admin/flags/#{@flag}/edit?return_to=show"}>
              Edit flag
            </.link>
          </.button>
        </:actions>
      </.header>
      
      <.display image_path={@flag.image_path}>
        <:item title="Name">{@flag.name}</:item>
        
        <:item title="Region">
          <.link navigate={~p"/regions/#{@flag.region.id}"}>
            <div class="link-hover">
              {@flag.region.name}
            </div>
          </.link>
        </:item>
        
        <:item title="Image path">{@flag.image_path}</:item>
      </.display>
      
      <.back navigate={~p"/admin/flags"}>Back to flags</.back>
    </div>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Flag")
     |> assign(:flag, Flags.get_flag_with_region!(id))}
  end
end
