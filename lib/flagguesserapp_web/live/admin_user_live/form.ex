defmodule FlagguesserappWeb.AdminUserLive.Form do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Users
  alias Flagguesserapp.Accounts.User

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header>
        <div class="text-xl font-extrabold">
          {@page_title}
        </div>
        
        <:subtitle>Use this form to manage user records in your database.</:subtitle>
      </.header>
      
      <.simple_form for={@form} id="user-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:username]} type="text" label="Name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <%= if @live_action == :new do %>
          <.input field={@form[:password]} type="text" label="Password" />
        <% end %>
        
        <.input
          field={@form[:is_admin]}
          type="select"
          label="Is Admin"
          options={[
            User: false,
            Admin: true
          ]}
        />
        <:actions>
          <.back navigate={return_path(@return_to, @user)} class="mt-0">Back</.back>
          
          <.button phx-disable-with="Saving...">Save User</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    user = Users.get_user!(id)

    socket
    |> assign(:page_title, "Edit user")
    |> assign(:user, user)
    |> assign(:form, to_form(Users.change_user(user)))
  end

  defp apply_action(socket, :new, _params) do
    user = %User{}

    socket
    |> assign(:page_title, "New user")
    |> assign(:user, user)
    |> assign(:form, to_form(Users.change_user(user)))
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Users.change_user(socket.assigns.user, user_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.live_action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    case Users.admin_update_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_user(socket, :new, user_params) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "user created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _user), do: ~p"/admin/users"
end
