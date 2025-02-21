defmodule FlagguesserappWeb.FlagLive.Index do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags
  alias Flagguesserapp.Regions

  import FlagguesserappWeb.CustomComponents

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:region_options, Regions.region_names_and_slugs())

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
    <.filter_form form={@form} region_options={@region_options} />
    <div class="flagcard-grid" id="flags" phx-update="stream">
      <.flag_card :for={{dom_id, flag} <- @streams.flags} flag={flag} id={dom_id} />
    </div>
    """
  end

  def filter_form(assigns) do
    ~H"""
    <.form for={@form} id="filter-form" phx-change="filter" class="filter-form">
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
          field={@form[:region]}
          prompt="Region"
          options={@region_options}
          class="filter-select"
        />
        <.input
          type="select"
          field={@form[:sort_by]}
          prompt="Sort By"
          options={[
            "Name: High to Low": "name_desc",
            "Name: Low to High": "name_asc",
            Region: "region"
          ]}
          class="filter-select"
        />
      </div>
      
      <.link patch={~p"/flags/overview/"} class="filter-reset">
        Reset
      </.link>
    </.form>
    """
  end

  def handle_event("filter", params, socket) do
    params =
      params
      |> Map.take(~w(q sort_by region))
      |> Map.reject(fn {_, v} -> v == "" end)

    socket = push_patch(socket, to: ~p"/flags/overview/?#{params}")

    {:noreply, socket}
  end
end
