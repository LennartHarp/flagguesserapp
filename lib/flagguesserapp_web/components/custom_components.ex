defmodule FlagguesserappWeb.CustomComponents do
  alias Flagguesserapp.Regions
  use FlagguesserappWeb, :html
  alias Flagguesserapp.Flags.Flag

  attr :flag, Flag
  slot :content
  slot :actions
  slot :result

  def quiz_card(assigns) do
    ~H"""
    <div class="quizcard">
      <div class="flex justify-center">
        <div>
          <%= if @flag do %>
            <div class="quizcard-image-container">
              <img src={@flag.image_path} alt="Flag" />
            </div>
             {render_slot(@content)}
          <% else %>
            <div class="quizcard-score">
              {render_slot(@result)}
            </div>
          <% end %>
        </div>
      </div>
      
      <div class="pt-3">
        {render_slot(@actions)}
      </div>
    </div>
    """
  end

  attr :image_path, :string

  def background(assigns) do
    ~H"""
    <div
      class="fixed inset-0 -z-10 bg-cover bg-center"
      style={"background-image: url(#{@image_path}); background-repeat: repeat-y; width: 100vw; height: 100vh;"}
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
        <div class="flex justify-center">
          <div class="flagcard-image-container">
            <img src={@flag.image_path} alt={@flag.name} />
          </div>
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
  attr :class, :string, default: nil

  def flag_simple_card(assigns) do
    ~H"""
    <.link navigate={~p"/flags/#{@flag}"}>
      <div class={@class}>
        <div class="flagcard">
          <div class="flex justify-center">
            <div class="flagcard-image-container">
              <img src={@flag.image_path} alt={@flag.name} />
            </div>
          </div>
          
          <div class="flagcard-content">
            <h2>{@flag.name}</h2>
          </div>
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
        <div class="sidebar-banner">
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

  slot :item, required: true do
    attr :title, :string, required: true
  end

  attr :image_path, :string, required: true

  def display(assigns) do
    ~H"""
    <div class="flex flex-row gap-4">
      <div class="display-image">
        <img src={@image_path} />
      </div>
      
      <dl class="w-2/3 -my-4 divide-y divide-zinc-100">
        <div :for={item <- @item} class="flex gap-4 py-4 text-sm leading-6 sm:gap-8">
          <dt class="w-1/4 flex-none text-zinc-500">{item.title}</dt>
          
          <dd class="text-zinc-700">{render_slot(item)}</dd>
        </div>
      </dl>
    </div>
    """
  end
end
