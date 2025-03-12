defmodule FlagguesserappWeb.RegionLive.Show do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  import FlagguesserappWeb.CustomComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header>
        {@region.name}
        <:subtitle>This is a region record from your database.</:subtitle>
        
        <:actions>
          <%= if @current_user && @current_user.is_admin do %>
            <.button phx-click={JS.dispatch("click", to: {:inner, "a"})}>
              <.link navigate={~p"/admin/regions/#{@region}/edit?return_to=show"}>
                Edit region
              </.link>
            </.button>
          <% end %>
        </:actions>
      </.header>
      
      <.display image_path={@region.image_path}>
        <:item title="Name">{@region.name}</:item>
        
        <:item title="Slug">{@region.slug}</:item>
        
        <:item title="Image path">{@region.image_path}</:item>
      </.display>
    </div>

    <div class="bg-white rounded p-4 m-2">
      <h2 class="text-lg font-extrabold leading-8 text-zinc-800 flex justify-center">
        Related Countries
      </h2>
    </div>

    <section class="mt-2">
      <div class="flagcard-grid">
        <.flag_simple_card :for={flag <- @region.flags} flag={flag} />
      </div>
    </section>

    <div class="bg-white rounded p-4 mt-2">
      <.back navigate={~p"/admin/regions"} class="mt-0">Back to regions</.back>
    </div>
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
