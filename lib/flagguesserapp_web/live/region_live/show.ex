defmodule FlagguesserappWeb.RegionLive.Show do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  import FlagguesserappWeb.CustomComponents

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      {@region.name}
      <:subtitle>This is a region record from your database.</:subtitle>
      
      <:actions>
        <.button phx-click={JS.dispatch("click", to: {:inner, "a"})}>
          <.link navigate={~p"/regions/#{@region}/edit?return_to=show"}>
            Edit region
          </.link>
        </.button>
      </:actions>
    </.header>

    <.list>
      <:item title="Name">{@region.name}</:item>
      
      <:item title="Slug">{@region.slug}</:item>
      
      <:item title="Image path">{@region.image_path}</:item>
    </.list>

    <section class="mt-12">
      <h4 class="estimator">Flags</h4>
       <div class="border-b-2 border-gray-400" />
      <div class="flagcard-grid">
        <.flag_simple_card :for={flag <- @region.flags} flag={flag} />
      </div>
    </section>

    <.back navigate={~p"/regions"}>Back to regions</.back>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Region")
     |> assign(:region, Regions.get_region_with_flags!(id))}
  end
end
