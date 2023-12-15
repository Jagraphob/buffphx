defmodule Buffphx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BuffphxWeb.Telemetry,
      Buffphx.Repo,
      {DNSCluster, query: Application.get_env(:buffphx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Buffphx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Buffphx.Finch},
      # Start a worker by calling: Buffphx.Worker.start_link(arg)
      # {Buffphx.Worker, arg},
      # Start to serve requests, typically the last entry
      BuffphxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Buffphx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BuffphxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
