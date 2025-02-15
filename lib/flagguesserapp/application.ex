defmodule Flagguesserapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FlagguesserappWeb.Telemetry,
      Flagguesserapp.Repo,
      {DNSCluster, query: Application.get_env(:flagguesserapp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Flagguesserapp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Flagguesserapp.Finch},
      # Start a worker by calling: Flagguesserapp.Worker.start_link(arg)
      # {Flagguesserapp.Worker, arg},
      # Start to serve requests, typically the last entry
      FlagguesserappWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Flagguesserapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlagguesserappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
