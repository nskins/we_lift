defmodule WeLift.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WeLiftWeb.Telemetry,
      # Start the Ecto repository
      WeLift.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WeLift.PubSub},
      # Start Finch
      {Finch, name: WeLift.Finch},
      # Start the Endpoint (http/https)
      WeLiftWeb.Endpoint
      # Start a worker by calling: WeLift.Worker.start_link(arg)
      # {WeLift.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeLift.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WeLiftWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
