defmodule FlagguesserappWeb.FlagLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags
  import FlagguesserappWeb.CustomComponents

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> stream(:flags, Flags.filter_flags(params), reset: true)
      |> assign(:form, to_form(params))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.filter_form form={@form} />
    <div
      class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 p-4"
      id="raffles"
      phx-update="stream"
    >
      <.flag_card :for={{dom_id, flag} <- @streams.flags} flag={flag} id={dom_id} />
    </div>
    """
  end

  def filter_form(assigns) do
    ~H"""
    <.form for={@form} id="filter-form" phx-change="filter" class="filter-form">
      <!-- Eingabefelder -->
      <div class="filter-fields">
        <.input
          field={@form[:q]}
          placeholder="Search..."
          autocomplete="off"
          phx-debounce="500"
          class="filter-input"
        />
        <.input
          type="select"
          field={@form[:continent]}
          prompt="Continent"
          options={[
            Africa: "africa",
            Asia: "asia",
            Europe: "europe",
            "North America": "northamerica",
            "South America": "southamerica",
            Oceania: "oceania"
          ]}
          class="filter-select"
        />
        <.input
          type="select"
          field={@form[:sort_by]}
          prompt="Sort By"
          options={[
            "Name: High to Low": "name_desc",
            "Name: Low to High": "name_asc"
          ]}
          class="filter-select"
        />
      </div>
      
    <!-- Reset-Link -->
      <.link patch={~p"/flags/overview/"} class="filter-reset">
        Reset
      </.link>
    </.form>
    """
  end

  attr :flag, Flagguesserapp.Flags.Flag, required: true
  attr :id, :string, required: true

  def flag_card(assigns) do
    ~H"""
    <.link navigate={~p"/flags/#{@flag}"} id={@id}>
      <div class="flagcard">
        <div class="flagcard-image">
          <img src={@flag.image_path} alt={@flag.name} />
        </div>
        
        <div class="flagcard-content">
          <h2>{@flag.name}</h2>
           <.badge continent={@flag.continent} class="flagcard-badge" />
        </div>
      </div>
    </.link>
    """
  end

  def handle_event("filter", params, socket) do
    params =
      params
      |> Map.take(~w(q continent sort_by))
      |> Map.reject(fn {_, v} -> v == "" end)

    socket = push_patch(socket, to: ~p"/flags/overview/?#{params}")

    {:noreply, socket}
  end
end
