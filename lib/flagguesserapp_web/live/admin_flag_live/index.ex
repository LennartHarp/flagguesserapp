defmodule FlagguesserappWeb.AdminFlagLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header>
        <div class="text-xl font-extrabold">
          Listing Flags
        </div>
        
        <:actions>
          <.button
            phx-click={JS.dispatch("click", to: {:inner, "a"})}
            class="!bg-gray-100 hover:!bg-gray-200"
          >
            <.link navigate={~p"/admin/flags/new"}>
              Create Flag
            </.link>
          </.button>
        </:actions>
      </.header>
      
      <.table
        id="flags"
        rows={@streams.flags}
        row_click={fn {_id, flag} -> JS.navigate(~p"/flags/#{flag}") end}
      >
        <:col :let={{_id, flag}} label="Name">{flag.name}</:col>
        
        <:col :let={{_id, flag}} label="Region">{flag.region.name}</:col>
        
        <:col :let={{_id, flag}} label="Image path">{flag.image_path}</:col>
        
        <:action :let={{_id, flag}}>
          <div class="sr-only">
            <.link navigate={~p"/flags/#{flag}"}>Show</.link>
          </div>
           <.link navigate={~p"/admin/flags/#{flag}/edit"}>Edit</.link>
        </:action>
        
        <:action :let={{id, flag}}>
          <.link
            phx-click={JS.push("delete", value: %{id: flag.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Flags")
     |> stream(:flags, Flags.list_flags_with_regions())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    flag = Flags.get_flag!(id)
    {:ok, _} = Flags.delete_flag(flag)

    {:noreply, stream_delete(socket, :flags, flag)}
  end
end
