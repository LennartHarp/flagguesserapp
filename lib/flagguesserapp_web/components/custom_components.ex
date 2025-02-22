defmodule FlagguesserappWeb.CustomComponents do
  alias Flagguesserapp.Regions
  use FlagguesserappWeb, :html
  alias Flagguesserapp.Flags.Flag

  attr :flag, Flag
  attr :choices, :list, default: []

  def quiz_card(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="flex justify-center">
        <div class="bg-white shadow-md rounded-lg p-6 w-80">
          <!-- Increased width to w-80 -->
          <%= if @flag do %>
            <div class="flex justify-center items-center mb-6 h-48 bg-gray-100 rounded">
              <!-- Increased height and added bg-gray-100 for visibility -->
              <img src={@flag.image_path} alt="Flag" class="max-w-full max-h-full object-contain" />
              <!-- Changed to object-contain -->
            </div>
            
            <div class="flex flex-col space-y-3">
              <%= for choice <- @choices do %>
                <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded text-sm w-full">
                  {choice}
                  <!-- Fixed syntax error -->
                </button>
              <% end %>
            </div>
          <% else %>
            <div class="text-center text-2xl font-bold text-green-600">
              Geschafft!
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  attr :region, :string, default: nil
  attr :class, :string, default: nil

  def badge(assigns) do
    ~H"""
    <div class={[
      "rounded-md px-2 py-1 text-xs font-medium inline-block border",
      @region == "Africa" && "text-lime-600 border-lime-600",
      @region == "Asia" && "text-amber-600 border-amber-600",
      @region == "Europe" && "text-gray-600 border-gray-600",
      @region == "North America" && "text-blue-600 border-lime-600",
      @region == "South America" && "text-red-600 border-amber-600",
      @region == "Oceania" && "text-yellow-600 border-gray-600",
      @class
    ]}>
      {@region}
    </div>
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
           <.badge region={@flag.region.name} class="flagcard-badge" />
        </div>
      </div>
    </.link>
    """
  end

  attr :flag, Flagguesserapp.Flags.Flag, required: true

  def flag_simple_card(assigns) do
    ~H"""
    <.link navigate={~p"/flags/#{@flag}"}>
      <div class="flagcard">
        <div class="flagcard-image">
          <img src={@flag.image_path} alt={@flag.name} />
        </div>
        
        <div class="flagcard-content">
          <h2>{@flag.name}</h2>
        </div>
      </div>
    </.link>
    """
  end

  slot :banner, required: true
  slot :navbar, required: true

  def side_bar(assigns) do
    ~H"""
    <div class="relative">
      <div id="sidebar" class="sidebar">
        <div class="sidebar-banner border-b-2 border-gray-400">
          {render_slot(@banner)}
        </div>
        
        <div class="sidebar-nav">
          {render_slot(@navbar)}
        </div>
      </div>
      
      <.button id="sidebar-toggle" phx-click={toggle_side_bar()}>
        <.icon name="hero-bars-3" />
      </.button>
    </div>
    """
  end

  def toggle_side_bar do
    JS.toggle(
      to: "#sidebar",
      in: {"ease-out duration-300", "-translate-x-full", "translate-x-0"},
      out: {"ease-in duration-300", "translate-x-0", "-translate-x-full"},
      time: 300
    )
  end

  def region_list(assigns) do
    ~H"""
    <div :for={region <- Regions.list_regions()}>
      <.link navigate={~p"/quiz/#{region.slug}"}>
        {region.name}
      </.link>
    </div>
    """
  end
end
