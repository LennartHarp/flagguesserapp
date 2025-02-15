defmodule FlagguesserappWeb.FlagLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Listing Flags
      <:actions>
        <.button phx-click={JS.dispatch("click", to: {:inner, "a"})}>
          <.link navigate={~p"/flags/new"}>
            New Flag
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
      <:col :let={{_id, flag}} label="Image path">{flag.image_path}</:col>
      <:action :let={{_id, flag}}>
        <div class="sr-only">
          <.link navigate={~p"/flags/#{flag}"}>Show</.link>
        </div>
        <.link navigate={~p"/flags/#{flag}/edit"}>Edit</.link>
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
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Flags")
     |> stream(:flags, Flags.list_flags())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    flag = Flags.get_flag!(id)
    {:ok, _} = Flags.delete_flag(flag)

    {:noreply, stream_delete(socket, :flags, flag)}
  end
end
