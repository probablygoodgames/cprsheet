defmodule Cprsheet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CprsheetWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cprsheet.PubSub},
      # Start Finch
      {Finch, name: Cprsheet.Finch},
      # Start the Endpoint (http/https)
      CprsheetWeb.Endpoint
      # Start a worker by calling: Cprsheet.Worker.start_link(arg)
      # {Cprsheet.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cprsheet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CprsheetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
