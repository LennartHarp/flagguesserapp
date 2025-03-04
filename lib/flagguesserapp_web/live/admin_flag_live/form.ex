defmodule FlagguesserappWeb.AdminFlagLive.Form do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags
  alias Flagguesserapp.Flags.Flag
  alias Flagguesserapp.Regions

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
      <:subtitle>Use this form to manage flag records in your database.</:subtitle>
    </.header>

    <.simple_form for={@form} id="flag-form" phx-change="validate" phx-submit="save">
      <.input field={@form[:name]} type="text" label="Name" />
      <.input
        field={@form[:region_id]}
        type="select"
        label="Region"
        prompt="Choose a Region"
        options={@region_options}
      /> <.input field={@form[:image_path]} type="text" label="Image path" />
      <:actions>
        <.button phx-disable-with="Saving...">Save Flag</.button>
      </:actions>
    </.simple_form>

    <.back navigate={return_path(@return_to, @flag)}>Back</.back>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> assign(:region_options, Regions.region_names_and_ids())
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    flag = Flags.get_flag!(id)

    socket
    |> assign(:page_title, "Edit Flag")
    |> assign(:flag, flag)
    |> assign(:form, to_form(Flags.change_flag(flag)))
  end

  defp apply_action(socket, :new, _params) do
    flag = %Flag{}

    socket
    |> assign(:page_title, "New Flag")
    |> assign(:flag, flag)
    |> assign(:form, to_form(Flags.change_flag(flag)))
  end

  @impl true
  def handle_event("validate", %{"flag" => flag_params}, socket) do
    changeset = Flags.change_flag(socket.assigns.flag, flag_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"flag" => flag_params}, socket) do
    save_flag(socket, socket.assigns.live_action, flag_params)
  end

  defp save_flag(socket, :edit, flag_params) do
    case Flags.update_flag(socket.assigns.flag, flag_params) do
      {:ok, flag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Flag updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, flag))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_flag(socket, :new, flag_params) do
    case Flags.create_flag(flag_params) do
      {:ok, flag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Flag created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, flag))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _flag), do: ~p"/admin/flags"
  defp return_path("show", flag), do: ~p"/flags/#{flag}"
end
