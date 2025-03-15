defmodule FlagguesserappWeb.FlagLive.Overview do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Flags
  alias Flagguesserapp.Regions

  import FlagguesserappWeb.CustomComponents

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:region_options, Regions.region_names_and_slugs())
      |> assign(:limit, 12)

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> stream(:flags, Flags.filter_flags(params, socket.assigns.limit), reset: true)
      |> assign(:form, to_form(params))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-white rounded-lg">
      <.filter_form form={@form} region_options={@region_options} />
    </div>

    <div class="flagcard-grid" id="flags" phx-update="stream">
      <.flag_card :for={{dom_id, flag} <- @streams.flags} flag={flag} id={dom_id} />
    </div>

    <%= if Enum.count(@streams.flags) < Enum.count(Flags.filter_flags(@form.params)) do %>
      <div class="flex justify-center">
        <button
          type="submit"
          label="Show all"
          phx-click={
            JS.push("show_more")
            |> JS.transition("opacity-100 translate-y-0", to: "#flags .flag-card")
          }
          class="bg-white rounded-lg px-4 py-2 my-4 font-semibold transition-transform hover:scale-105"
        >
          Show More <.icon name="hero-chevron-down" />
        </button>
      </div>
    <% end %>
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
      
      <.link patch={~p"/"} class="filter-reset">
        Reset
      </.link>
    </.form>
    """
  end

  def handle_event("filter", params, socket) do
    socket =
      socket
      |> assign(:limit, 12)

    params =
      params
      |> Map.take(~w(q sort_by region))
      |> Map.reject(fn {_, v} -> v == "" end)

    socket = push_patch(socket, to: ~p"/?#{params}")

    {:noreply, socket}
  end

  def handle_event("show_more", _params, socket) do
    IO.inspect(socket.assigns.form)

    params =
      socket.assigns.form.params
      |> Map.take(~w(q sort_by region))
      |> Map.reject(fn {_, v} -> v == "" end)

    socket =
      socket
      |> update(:limit, &(&1 + 6))
      |> push_patch(to: ~p"/?#{params}")

    {:noreply, socket}
  end
end
