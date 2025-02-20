defmodule FlagguesserappWeb.CustomComponents do
  use FlagguesserappWeb, :html
  alias Flagguesserapp.Flags.Flag

  attr :flag, Flag, required: true
  attr :choices, :list, required: true

  def quiz_card(assigns) do
    ~H"""
    <div class="bg-white p-6 rounded-lg shadow-lg mb-6">
      <img src={@flag.image_path} class="rounded-lg shadow-lg border-2 border-gray-300 mb-6" />
      <div class="grid grid-cols-2 gap-4">
        <%= for name <- @choices do %>
          <button class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none transition duration-200">
            {name}
          </button>
        <% end %>
      </div>
    </div>
    """
  end

  attr :continent, :atom,
    values: [:africa, :asia, :europe, :northamerica, :southamerica, :oceania],
    default: :europe

  attr :class, :string, default: nil

  def badge(assigns) do
    ~H"""
    <div class={[
      "rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border",
      @continent == :africa && "text-lime-600 border-lime-600",
      @continent == :aisa && "text-amber-600 border-amber-600",
      @continent == :europe && "text-gray-600 border-gray-600",
      @continent == :northamerica && "text-blue-600 border-lime-600",
      @continent == :southamerica && "text-red-600 border-amber-600",
      @continent == :oceania && "text-yellow-600 border-gray-600",
      @class
    ]}>
      {@continent}
    </div>
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
end
