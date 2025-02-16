defmodule FlagguesserappWeb.QuizLive.Index do
  use FlagguesserappWeb, :live_view

  import FlagguesserappWeb.CustomComponents
  alias Flagguesserapp.Flags

  def render(assigns) do
    ~H"""
    <.quiz_card flag={@flag} choices={@choices} />
    """
  end

  def mount(_params, _session, socket) do
    flag = Flags.random_flag()
    choices = random_flag_names(flag)

    {:ok,
     socket
     |> assign(:page_title, "Flag Quiz!")
     |> assign(:flag, flag)
     |> assign(:choices, choices)
     |> stream(:flags, Flags.list_flags())}
  end

  defp random_flag_names(flag) do
    all_flags = Flags.list_flags() |> Enum.filter(fn f -> f.name != flag.name end)

    other_names =
      all_flags
      |> Enum.take_random(3)
      |> Enum.map(& &1.name)

    [flag.name | other_names]
    |> Enum.shuffle()
  end
end
