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
          <.link navigate={~p"/admin/regions/#{@region}/edit?return_to=show"}>
            Edit region
          </.link>
        </.button>
      </:actions>
    </.header>

    <.display image_path={@region.image_path}>
      <:item title="Name">{@region.name}</:item>
      
      <:item title="Slug">{@region.slug}</:item>
      
      <:item title="Image path">{@region.image_path}</:item>
    </.display>

    <section class="mt-12">
      <h2 class="text-lg font-semibold leading-8 text-zinc-800">Nations</h2>
       <div class="border-t border-zinc-100 mb-6" />
      <div class="flagcard-grid">
        <.flag_simple_card :for={flag <- @region.flags} flag={flag} />
      </div>
    </section>

    <.back navigate={~p"/admin/regions"}>Back to regions</.back>
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
