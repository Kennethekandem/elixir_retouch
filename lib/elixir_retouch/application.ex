defmodule ElixirRetouch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirRetouchWeb.Telemetry,
      ElixirRetouch.Repo,
      {DNSCluster, query: Application.get_env(:elixir_retouch, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirRetouch.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirRetouch.Finch},
      # Start a worker by calling: ElixirRetouch.Worker.start_link(arg)
      # {ElixirRetouch.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirRetouchWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirRetouch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirRetouchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
