defmodule FlagguesserappWeb.AdminRegionLive.Form do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Regions
  alias Flagguesserapp.Regions.Region

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded p-4">
      <.header>
        <div class="text-xl font-extrabold">
          {@page_title}
        </div>
        
        <:subtitle>Use this form to manage region records in your database.</:subtitle>
      </.header>
      
      <.simple_form for={@form} id="region-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:slug]} type="text" label="Slug" />
        <.input field={@form[:image_path]} type="text" label="Image path" />
        <:actions>
          <.back navigate={return_path(@return_to, @region)} class="mt-0">Back</.back>
          
          <.button phx-disable-with="Saving...">Save Region</.button>
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
    region = Regions.get_region!(id)

    socket
    |> assign(:page_title, "Edit Region")
    |> assign(:region, region)
    |> assign(:form, to_form(Regions.change_region(region)))
  end

  defp apply_action(socket, :new, _params) do
    region = %Region{}

    socket
    |> assign(:page_title, "New Region")
    |> assign(:region, region)
    |> assign(:form, to_form(Regions.change_region(region)))
  end

  @impl true
  def handle_event("validate", %{"region" => region_params}, socket) do
    changeset = Regions.change_region(socket.assigns.region, region_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"region" => region_params}, socket) do
    save_region(socket, socket.assigns.live_action, region_params)
  end

  defp save_region(socket, :edit, region_params) do
    case Regions.update_region(socket.assigns.region, region_params) do
      {:ok, region} ->
        {:noreply,
         socket
         |> put_flash(:info, "Region updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, region))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_region(socket, :new, region_params) do
    case Regions.create_region(region_params) do
      {:ok, region} ->
        {:noreply,
         socket
         |> put_flash(:info, "Region created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, region))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _region), do: ~p"/admin/regions"
  defp return_path("show", region), do: ~p"/regions/#{region}"
end
