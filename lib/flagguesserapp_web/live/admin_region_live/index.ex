defmodule FlagguesserappWeb.AdminRegionLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header>
        <div class="text-xl font-extrabold">
          Listing Regions
        </div>
        
        <:actions>
          <.button
            phx-click={JS.dispatch("click", to: {:inner, "a"})}
            class="!bg-gray-100 hover:!bg-gray-200"
          >
            <.link navigate={~p"/admin/regions/new"}>
              Create Region
            </.link>
          </.button>
        </:actions>
      </.header>
      
      <.table
        id="regions"
        rows={@streams.regions}
        row_click={fn {_id, region} -> JS.navigate(~p"/regions/#{region}") end}
      >
        <:col :let={{_id, region}} label="Name">{region.name}</:col>
        
        <:col :let={{_id, region}} label="Slug">{region.slug}</:col>
        
        <:col :let={{_id, region}} label="Image path">{region.image_path}</:col>
        
        <:action :let={{_id, region}}>
          <div class="sr-only">
            <.link navigate={~p"/regions/#{region}"}>Show</.link>
          </div>
           <.link navigate={~p"/admin/regions/#{region}/edit"}>Edit</.link>
        </:action>
        
        <:action :let={{id, region}}>
          <.link
            phx-click={JS.push("delete", value: %{id: region.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Regions")
     |> stream(:regions, Regions.list_regions())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    region = Regions.get_region!(id)
    {:ok, _} = Regions.delete_region(region)

    {:noreply, stream_delete(socket, :regions, region)}
  end
end
