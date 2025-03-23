defmodule FlagguesserappWeb.QuizLive.ModeParser do
  alias Flagguesserapp.Regions

  # Regions
  def parse_region(%{"region" => region, "mode" => "best-of-ten"}) do
    Regions.get_region_with_flags_with_limit!(region, 10)
  end

  def parse_region(%{"region" => region, "mode" => "best-of-twenty"}) do
    Regions.get_region_with_flags_with_limit!(region, 20)
  end

  def parse_region(%{"region" => region, "mode" => "best-of-all"}) do
    Regions.get_region_with_flags!(region)
  end

  def parse_region(%{"region" => region, "mode" => _mode}) do
    Regions.get_region_with_flags!(region)
  end
end
