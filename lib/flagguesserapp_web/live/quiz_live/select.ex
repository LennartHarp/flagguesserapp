defmodule FlagguesserappWeb.QuizLive.Select do
  use FlagguesserappWeb, :live_view

  alias Flagguesserapp.Modes
  alias Flagguesserapp.Regions

  def render(assigns) do
    ~H"""
    <div class="bg-white rounded-lg p-3">
      <h1 class="text-2xl font-semibold flex justify-center">Choose Region</h1>
    </div>

    <div id="region-select">
      <div class="flagcard-grid">
        <button
          :for={{dom_id, region} <- @streams.regions}
          id={dom_id}
          type="button"
          phx-click={select("region-select", "mode-select")}
          phx-value-region={region.slug}
          class="flagcard-grid-button"
        >
          {region.name}
        </button>
      </div>
    </div>

    <div id="mode-select" class="hidden">
      <div class="flagcard-grid">
        <button
          :for={{dom_id, mode} <- @streams.modes}
          id={dom_id}
          type="button"
          phx-click={select("mode-select", "start-quiz")}
          phx-value-mode={mode.slug}
          class="flagcard-grid-button"
        >
          {mode.name}
        </button>
      </div>
      
      <button
        type="button"
        phx-click={select("mode-select", "region-select")}
        class="flagcard-grid-button"
      >
        <.icon name="hero-arrow-uturn-left" />
      </button>
    </div>

    <div id="start-quiz" class="hidden">
      <div class="flex justify-center items-center">
        <button type="button" phx-click="start" class="flagcard-grid-button">
          <.icon name="hero-play-circle-solid" />
        </button>
      </div>
      
      <button
        type="button"
        phx-click={select("start-quiz", "mode-select")}
        class="flagcard-grid-button"
      >
        <.icon name="hero-arrow-uturn-left" />
      </button>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:regions, Regions.list_regions(), reset: true)
     |> stream(:modes, Modes.list_modes(), reset: true)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("start", _params, socket) do
    params =
      socket.assigns
      |> Map.take([:mode, :region])
      |> Map.reject(fn {_, v} -> v == "" end)
      |> Map.new(fn {k, v} -> {Atom.to_string(k), v} end)

    {:noreply, redirect(socket, to: ~p"/quiz/?#{params}")}
  end

  def handle_event("validate", %{"region" => region}, socket) do
    {:noreply, assign(socket, :region, region)}
  end

  def handle_event("validate", %{"mode" => mode}, socket) do
    {:noreply, assign(socket, :mode, mode)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def select(dom_id, dest_dom_id) do
    JS.push("validate")
    |> JS.hide(to: "##{dom_id}")
    |> JS.show(to: "##{dest_dom_id}")
    |> JS.transition({"ease-out duration-300", "opacity-0", "opacity-100"}, to: "##{dest_dom_id}")
  end
end
