defmodule FlagguesserappWeb.CustomComponents do
  alias Flagguesserapp.Regions
  use FlagguesserappWeb, :html
  alias Flagguesserapp.Flags.Flag

  attr :flag, Flag
  slot :content
  slot :actions

  def quiz_card(assigns) do
    ~H"""
    <div class="quizcard">
      <div class="flex justify-center">
        <div>
          <%= if @flag do %>
            <div class="w-64 h-32 flex items-center justify-center bg-white">
              <img src={@flag.image_path} alt="Flag" class="max-w-full max-h-full object-contain" />
            </div>
             {render_slot(@content)}
          <% else %>
            <div class="quizcard_score">
              Geschafft!
            </div>
          <% end %>
        </div>
      </div>
       {render_slot(@actions)}
    </div>
    """
  end

  attr :image_path, :string

  def background(assigns) do
    ~H"""
    <div
      class="absolute inset-x-0 bottom-0 h-full -z-10 bg-cover bg-center"
      style={"background-image: url(#{@image_path})"}
    />
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
      <div id="sidebar" class="sidebar hidden">
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
