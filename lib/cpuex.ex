defmodule Cpuex do
  use Application

  def config_dir() do
    Path.join([Desktop.OS.home(), ".config", "cpuex"])
  end

  @app Mix.Project.config()[:app]
  def start(:normal, []) do
    File.mkdir_p!(config_dir())

    :session = :ets.new(:session, [:named_table, :public, read_concurrency: true])

    children = [
      {Phoenix.PubSub, name: Cpuex.PubSub},
      CpuexWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Cpuex.Supervisor]
    {:ok, sup} = Supervisor.start_link(children, opts)

    {:ok, {_ip, port}} = Bandit.PhoenixAdapter.server_info(CpuexWeb.Endpoint, :http)

    {:ok, _} =
      Supervisor.start_child(sup, {
        Desktop.Window,
        [
          app: @app,
          id: CpuexWindow,
          title: "cpuex",
          size: {400, 800},
          url: "http://localhost:#{port}"
        ]
      })
  end

  def config_change(changed, _new, removed) do
    CpuexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
