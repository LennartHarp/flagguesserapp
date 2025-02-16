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
end
