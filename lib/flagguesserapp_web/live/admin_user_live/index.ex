defmodule FlagguesserappWeb.AdminUserLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Users

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header>
        <div class="text-xl font-extrabold">
          Listing Users
        </div>
        
        <:actions>
          <.button
            phx-click={JS.dispatch("click", to: {:inner, "a"})}
            class="!bg-gray-100 hover:!bg-gray-200"
          >
            <.link navigate={~p"/admin/users/new"}>
              Create user
            </.link>
          </.button>
        </:actions>
      </.header>
      
      <.table id="users" rows={@streams.users}>
        <:col :let={{_id, user}} label="Name">{user.username}</:col>
        
        <:col :let={{_id, user}} label="Email">{user.email}</:col>
        
        <:col :let={{_id, user}} label="Is Admin">{user.is_admin}</:col>
        
        <:action :let={{_id, user}}>
          <.link navigate={~p"/admin/users/#{user}/edit"}>Edit</.link>
        </:action>
        
        <:action :let={{id, user}}>
          <.link
            phx-click={JS.push("delete", value: %{id: user.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Users")
     |> stream(:users, Users.list_users())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, stream_delete(socket, :users, user)}
  end
end
