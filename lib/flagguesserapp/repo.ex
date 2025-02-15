defmodule Flagguesserapp.Repo do
  use Ecto.Repo,
    otp_app: :flagguesserapp,
    adapter: Ecto.Adapters.Postgres
end
